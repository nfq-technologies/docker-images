#!/bin/bash

set -x
set -e


cp -frv /build/files/* / || true


# No nead for standart clone project script
rm /etc/rc.d/200-git-clone-the-project
rm /etc/rc.d/900-execute-project-init-script

# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

