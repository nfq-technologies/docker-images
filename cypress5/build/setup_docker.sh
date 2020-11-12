#!/bin/bash

set -x
set -e

# Install fontforge
apt-get update
apt-get install -y --no-install-recommends libgtk-3-0 libgbm1 libnss3 libxss1 libasound2 libxtst6 xauth xvfb



# cypress
yarn global add cypress@5
cypress verify
ln -s /usr/local/bin/cypress /usr/bin/cypress


mv /root/.cache /home/project/.cache
chown -R 1000:1000 /home/project/.cache


# Copy runtime files
cp -frv /build/files/* / || true

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

