#!/bin/bash

set -x
set -e

source "/tools/common_rc/functions.sh"

apt-get update


# install SSHD
apt-get install -y --no-install-recommends ssh

# let root logins, disable password logins
sed -i \
-e 's/^#?UsePAM.*$/UsePAM no/g' \
-e 's/^#?PasswordAuthentication.*$/PasswordAuthentication yes/g' \
-e 's/^#?PermitRootLogin.*$/PermitRootLogin yes/g' \
-e 's/^#?UseDNS.*$/UseDNS no/g' \
-e 's/AcceptEnv LANG.*//' \
/etc/ssh/sshd_config
mkdir -p /var/run/sshd
echo 'root:root' | chpasswd


echo "
### Install git with flow and lfs plugins ...
"
apt-get install -y --no-install-recommends openssh-client git git-flow

wget https://packagecloud.io/github/git-lfs/packages/debian/buster/git-lfs_2.9.0_amd64.deb/download -O /tmp/git-lfs.deb
dpkg -i /tmp/git-lfs.deb
rm -r /tmp/git-lfs.deb
git lfs install --system --skip-smudge



echo 'Setup nice PS1 to use with git...' \
&& wget -q "https://gist.githubusercontent.com/dariuskt/0e0b714a4cf6387d7178/raw/83065e2fead22bb1c2ddf809be05548411eabea7/git_bash_prompt.sh" -O /home/project/.git_bash_prompt.sh \
&& echo '. ~/.git_bash_prompt.sh' >> /home/project/.bashrc \
&& chown project:project /home/project/.git_bash_prompt.sh \
&& echo -e '\n\nDONE\n'


# make directories not that dark on dark background
echo 'DIR 30;47' > /home/project/.dircolors
chown project:project /home/project/.dircolors


echo 'adding git aliases...' \
&& echo alias gl=\"git log --pretty=format:\'%C\(bold blue\)%h %Creset-%C\(bold yellow\)%d %C\(red\)%an %C\(green\)%s\' --graph --date=short --decorate --color --all\" >> /home/project/.bash_aliases \
&& echo 'alias pull-all='\''CB=$(git branch | grep ^\* | cut -d" " -f2); git branch | grep -o [a-z].*$ | xargs -n1 -I{} bash -c "git checkout {} && git pull"; git checkout "$CB"'\' >> /home/project/.bash_aliases \
&& chown project:project /home/project/.bash_aliases \
&& echo -e '\n\nDONE\n'


echo 'enable bash_custom inside dev container'
echo 'if [ -f ~/.bash_custom ]; then . ~/.bash_custom ; fi' >> /home/project/.bashrc


# install mysql-client
apt-get install -y --no-install-recommends mariadb-client


# install composer
phpEnableModule json
phpEnableModule phar
phpEnableModule zip
phpEnableModule iconv
phpEnableModule mbstring
apt-get install -y --no-install-recommends composer

# installl hiroku/prestissimo
phpEnableModule curl
sudo -u project composer --no-interaction global require "hirak/prestissimo:^0.3"

# disable enabled modules
phpDisableModule json
phpDisableModule phar
phpDisableModule zip
phpDisableModule iconv
phpDisableModule mbstring
phpDisableModule curl


# install phpunit
apt-get install -y --no-install-recommends phpunit
phpEnableModule phar


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

