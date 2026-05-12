#!/bin/bash

# xdebug-config daemon removed - no longer needed
# xdebug-config now uses Docker API directly

# Add user to docker socket group if socket is mounted
# This allows xdebug-config to communicate with Docker API without sudo
for sock in /var/run/docker.sock /run/docker.sock; do
    if [ -S "$sock" ]; then
        DOCKER_GID=$(stat -c '%g' "$sock" 2>/dev/null)
        if [ -n "$DOCKER_GID" ] && [ "$DOCKER_GID" != "0" ]; then
            # Create or update docker group with correct GID
            if ! getent group docker >/dev/null 2>&1; then
                groupadd -g "$DOCKER_GID" docker 2>/dev/null || true
            elif [ "$(getent group docker | cut -d: -f3)" != "$DOCKER_GID" ]; then
                groupmod -g "$DOCKER_GID" docker 2>/dev/null || true
            fi
            # Add project user to docker group
            usermod -aG docker project 2>/dev/null || true
        fi
        break
    fi
done
