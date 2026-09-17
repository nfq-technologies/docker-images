#!/bin/bash

set -x
set -e

# Claude Code release channel or exact version (stable | latest | X.Y.Z)
CLAUDE_VERSION=stable

# Install Claude Code natively for the project user (no Node.js needed).
# Binary lands in /home/project/.local/bin/claude.
sudo -u project -H bash -c "set -o pipefail; curl -fsSL https://claude.ai/install.sh | bash -s '$CLAUDE_VERSION'"

# Config dir: a named volume mounted here inherits this ownership on first use,
# which is what lets the project user write the OAuth token.
install -d -o project -g project -m 700 /home/project/.claude

# Copy runtime files
cp -frv /build/files/* /
chmod +x /entrypoint.sh /usr/local/bin/claude /usr/local/bin/ssh-askpass-project

# Fail the build if the install is broken
sudo -u project -H /home/project/.local/bin/claude --version

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
