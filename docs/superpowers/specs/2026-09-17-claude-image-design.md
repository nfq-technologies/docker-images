# `nfqlt/claude` image design

Date: 2026-09-17
Status: approved by user in brainstorming, pending spec review

## Goal

Provide a Docker image that colleagues add as one service to an existing
docker-compose project so they can use Claude Code on that project only.
Claude must be able to see the project files, reach the other compose
services, run the project's tooling inside the dev container, and use the
internet. It must not be able to interact with the host machine.

## Non-goals

- Reading `docker compose logs`, restarting services, or any Docker API access.
  This needs a project-scoped socket proxy that does not exist; a read-only
  proxy can be layered on later as an opt-in if logs become a real pain.
- Egress firewalling. Internet access is explicitly allowed.
- API-key or Bedrock/Vertex authentication. Colleagues log in with their
  claude.ai subscription (OAuth).
- A separate `toolbox`/sshd variant. Nothing needs to SSH into this container.

## Chosen approach

A `claude` container on the compose network, with the project directory as its
only bind mount, that executes selected commands inside the dev container over
SSH using the existing `map-remote-tools` mechanism from the base image.

Alternatives rejected:

- Docker CLI + `tecnativa/docker-socket-proxy`: the proxy filters by API
  endpoint, not by compose project, so allowing `exec` and container `POST`
  lets Claude reach every container on the host or create one that mounts `/`.
- Read-only socket proxy: safe for the host filesystem but leaks logs and
  environment variables of every container on a shared machine.

## Colleague-facing contract

One service, one named volume, run with `docker compose exec`:

```yaml
services:
  claude:
    image: nfqlt/claude
    working_dir: /home/project/src
    volumes:
      - './src:/home/project/src'           # must match the dev container path
      - 'claude-home:/home/project/.claude'  # OAuth token, settings, history
    environment:
      NFQ_REMOTE_TOOL_DEV: >
        /usr/bin/php
        /usr/local/bin/composer
      # optional, for commits made by Claude:
      # GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, GIT_COMMITTER_NAME, GIT_COMMITTER_EMAIL
    cap_drop: [ALL]
    cap_add: [SETUID, SETGID]
    security_opt: [no-new-privileges:true]

volumes:
  claude-home:
```

```
docker compose up -d claude
docker compose exec claude claude
```

- First run: Claude Code prints a login URL. The colleague opens it in their host
  browser, gets a code, pastes it into the terminal. The token is stored in the
  `claude-home` volume. Compose prefixes named volumes with the project name,
  so each project has its own login and history with no extra configuration.
- `NFQ_REMOTE_TOOL_<SERVICE>` lists absolute command paths. Each becomes a
  wrapper in the claude container that runs the same path inside
  `<service>` via `ssh project@<service>` in the same working directory. This
  is why the project must be mounted at the same path in both containers.
- Everything else on the compose network is reachable normally
  (`curl web`, `mysql -h mysql`, etc.).
- The container has no Docker socket, no Docker CLI, no host paths other than
  the project directory, and only the two capabilities needed to drop from
  root to the `project` user.

## Image layout (`claude/`)

Follows the repo convention: `Dockerfile`, `build/setup_docker.sh`,
`build/files/`, `Makefile -> ../_tools/makefiles/base-image-Makefile`,
`test/`, `README.md`.

### Dockerfile

```dockerfile
FROM nfqlt/debian-trixie

ENV CLAUDE_CONFIG_DIR=/home/project/.claude
CMD exec /entrypoint.sh

ADD build /build
RUN bash /build/setup_docker.sh && rm -Rf /build
```

No `USER` instruction, matching every other nfqlt image. The uid drop happens
in the `claude` wrapper.

Base is `debian-trixie` rather than `debian-bookworm`: it is complete and
published (level 1, `php85-cli` already builds on it), has the rc.d symlinks
for remote tools, and Debian 13 has a longer support horizon. The Claude binary
is a static glibc build and does not depend on the distro. Dev containers on
bookworm interoperate fine because the only link is SSH.

### `build/setup_docker.sh`

1. `CLAUDE_VERSION=stable` at the top of the script, in the same spirit as
   `ver=24` in the node images. Each CI rebuild picks up the current stable
   release. Change the variable to pin a specific version.
2. Install Claude Code with the official native installer as the `project`
   user: `sudo -u project bash -c 'curl -fsSL https://claude.ai/install.sh | bash -s "$CLAUDE_VERSION"'`.
   The binary lands in `/home/project/.local/bin/claude`. No Node.js, no npm.
3. `install -d -o project -g project -m 700 /home/project/.claude`. A named
   volume mounted on an empty path inherits the ownership of the image
   directory it covers, so this is what lets the `project` user write the
   OAuth token on first login.
4. `cp -frv /build/files/* /` and the standard `cleanup_apt.sh`.
5. Verify `sudo -u project /home/project/.local/bin/claude --version` succeeds
   so a broken download fails the build, not the first user.

### `build/files/`

- `entrypoint.sh`
  ```bash
  #!/bin/bash
  set -e
  run-parts -v /etc/rc.d           # generates remote-tool wrappers as root
  trap 'exit 0' TERM INT
  while :; do sleep 1 & wait $!; done
  ```
  The trap loop exists because `sleep infinity` as PID 1 ignores SIGTERM and
  makes `docker compose stop` wait for the kill timeout.

- `usr/local/bin/claude`
  ```bash
  #!/bin/bash
  BIN="${CLAUDE_BIN:-/home/project/.local/bin/claude}"   # override exists for tests
  if [ "$(id -u)" = "0" ]; then
      exec setpriv --reuid=project --regid=project --init-groups \
           env HOME=/home/project USER=project "$BIN" "$@"
  fi
  exec "$BIN" "$@"
  ```
  `setpriv` is in util-linux and present in the trixie base. Dropping uid from
  root needs `CAP_SETUID`/`CAP_SETGID`, hence `cap_add` in the compose snippet.
  `no-new-privileges` does not block a root process voluntarily dropping.

- `etc/claude-code/managed-settings.json`
  ```json
  { "env": { "DISABLE_AUTOUPDATER": "1" } }
  ```
  Highest-precedence settings tier. Auto-update is off because the image is
  immutable and updates would land in the image layer, not the volume. Nothing
  else is set here; team or project defaults belong in the project's own
  `.claude/settings.json`, which is inside the bind mount.

### `test/` (run by `make test` via `run-parts -a <image>`)

Each script receives the image reference as `$1` and uses `docker run --rm $1`.

1. `claude_available` — `claude --version` succeeds as root through the
   wrapper under `--cap-drop ALL --cap-add SETUID --cap-add SETGID
   --security-opt no-new-privileges`, and directly with `-u project`.
2. `config_present` — `printenv CLAUDE_CONFIG_DIR` equals
   `/home/project/.claude`; `/etc/claude-code/managed-settings.json` parses
   with `jq`.
3. `remote_tools_mapped` — with `-e NFQ_REMOTE_TOOL_DEV=/usr/bin/php`, running
   `run-parts /etc/rc.d` produces an executable `/usr/bin/php` containing
   `host="dev"`.
4. `no_docker_cli` — `command -v docker` fails.
5. `stopping_in_2000_ms` — start the container detached, `docker stop`, assert
   it took under 2 s (mirrors `toolbox-bookworm/test/stopping_in_2000_ms`).

### Manual end-to-end check on dvm (not part of `make test`)

Compose file in the scratchpad with `claude` and a `dev: nfqlt/php85-dev`
service sharing a bind-mounted directory and `NFQ_REMOTE_TOOL_DEV=/usr/bin/php`.
`docker compose exec claude php -v` must print the PHP version from the dev
container. `docker compose exec claude claude --version` must print the Claude
Code version. Login itself is not automated; it is verified once by hand.

## Other repo changes

- `claude/README.md` in the existing per-image README format: what it is, the
  compose snippet above, first-login steps, how remote tools work, git identity
  env vars, and an explicit "what it cannot do" list (no logs, no restarts, no
  host access).
- Run `_tools/regenerate-all.sh` so `_tools/gitlab/level_2/config.yml` gains
  the `claude` jobs and `_docs/media/image_relations.*` include the node.
- The `build/files/usr/local/bin/.claude/settings.local.json` files seen in
  `debian-bookworm` and `debian-trixie` turned out to be untracked local
  artifacts (created by a Claude Code session run inside those directories and
  hidden by the developer's global gitignore rule `**/.claude/settings.local.json`).
  They were never in git or in CI-built images. They were deleted from the
  local checkout; no repository change was needed.

## Build and verification loop

The dvm multipass instance (Ubuntu 24.04, arm64, Docker 29) holds a plain copy
of the repo at `/home/ubuntu/git/docker-images` (not a git clone). Sync with
`multipass transfer -r`, then in the VM:

```
cd ~/git/docker-images/claude && make build-arm64 && make test-arm64
```

`build-arch` rewrites `FROM nfqlt/...` to `docker.nfq.lt/nfqlt/...` and pulls;
anonymous pulls from that registry work from dvm. amd64 is built by CI.

## Open points settled

- Version policy: `stable` channel, rebuilt by CI. Pinning is a one-line change.
- Runtime user: `project` (uid 1000) via wrapper, root only for rc.d.
- Where team defaults go: managed settings only disable auto-update; anything
  project-specific lives in the project repo.
