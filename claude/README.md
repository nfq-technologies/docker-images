## Claude Code toolbox

### Info
Claude Code (Anthropic's CLI coding agent) in a container that is added to an
existing docker-compose project. Claude sees the project files and the other
compose services, can run the project's tooling inside the dev container, and
has internet access. It has no access to the host machine: no Docker socket,
no Docker CLI, no host paths other than the project directory.

Built on `nfqlt/debian-trixie`. Claude Code is installed natively (no Node.js)
for the `project` user (uid 1000) and tracks the `stable` release channel at
image build time. Auto-update is disabled inside the image.

### Sample configuration
```
services:
  dev:
    image: nfqlt/php85-dev
    volumes:
      - './src:/home/project/src'

  claude:
    image: nfqlt/claude
    working_dir: /home/project/src
    volumes:
      - './src:/home/project/src'           # same path as in the dev container
      - 'claude-home:/home/project/.claude'  # login token, settings, history
    environment:
      NFQ_REMOTE_TOOL_DEV: >
        /usr/bin/php
        /usr/local/bin/composer
      # Optional, so commits made by Claude are attributed to you:
      # GIT_AUTHOR_NAME: Your Name
      # GIT_AUTHOR_EMAIL: you@example.com
      # GIT_COMMITTER_NAME: Your Name
      # GIT_COMMITTER_EMAIL: you@example.com
    cap_drop: [ALL]
    cap_add: [SETUID, SETGID]
    security_opt: [no-new-privileges:true]

volumes:
  claude-home:
```

The `cap_drop`, `cap_add`, and `security_opt` lines are required, not
decorative: the base image gives `project` passwordless sudo, and these are
what keep root out of reach inside the container.

### Usage
```
docker compose up -d claude
docker compose exec claude claude
```

`docker compose exec` runs as root, but the `claude` command drops to the
`project` user before starting Claude Code, so files it creates in the project
are owned by uid 1000 like everything the dev container writes. `CLAUDE_BIN`
overrides which binary the wrapper drops privileges to run, for testing.

### First login
On the first run Claude Code shows a login URL. Open it in your browser on the
host, sign in with your claude.ai account, copy the code it shows, and paste
the code into the terminal. The token is stored in the `claude-home` volume.
Compose prefixes named volumes with the project name, so every project has its
own login and session history.

### Running commands inside the dev container
`NFQ_REMOTE_TOOL_<SERVICE>` lists absolute command paths. For each one the
container gets a wrapper at that path which runs the same path inside
`<service>` over SSH, in the same working directory. With the sample above,
`php`, `composer`, and anything Claude runs through them execute in `dev`,
not in the claude container. This is why the project must be mounted at the
same path in both containers. The SSH login uses the `project` user's default
password, which this image answers automatically (`SSH_ASKPASS`), so nothing
needs to be configured on the dev side.

Other services are reachable normally on the compose network
(`curl web`, `mysql -h mysql -u root`, ...).

### Project-level Claude settings
Put `CLAUDE.md`, `.claude/settings.json`, hooks, and MCP configuration in the
project repository as usual. They are inside the bind mount, so Claude picks
them up and they are shared with the team through git.

### What this container cannot do
- Read `docker compose logs`, restart services, or use the Docker API.
- See anything on the host outside the mounted project directory.
- Use your host `~/.gitconfig`, `~/.ssh`, or other dotfiles. Pass what you
  need explicitly via environment variables.
- Log in to SSH hosts that expect a key or another password: `ssh` inside
  this container always answers `project`. To let Claude push over SSH,
  mount a key and set `SSH_ASKPASS_REQUIRE=never` on the service — but that
  also disables the askpass answer for the `NFQ_REMOTE_TOOL_*` wrappers, so
  pick one or the other.
