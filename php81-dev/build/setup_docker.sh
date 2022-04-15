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
apt-get install -y --no-install-recommends openssh-client git git-flow git-lfs

git lfs install --system --skip-smudge



echo 'Setup nice PS1 to use with git...' \
&& wget -q "https://gist.githubusercontent.com/devopsnfq/75045ae9f3f3ad49b50a61315e22d144/raw/27dbc5aecdedd7843508b205129cf7a1329a17a6/git_bash_prompt.sh" -O /home/project/.git_bash_prompt.sh \
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
phpEnableModule phar
phpEnableModule zip
phpEnableModule iconv
phpEnableModule mbstring
phpEnableModule curl

curl -sSL 'https://getcomposer.org/download/latest-1.x/composer.phar' > /usr/local/bin/composer_v1.phar
curl -sSL 'https://getcomposer.org/download/latest-2.2.x/composer.phar' > /usr/local/bin/composer_v2.phar
chmod a+x /usr/local/bin/composer*.phar
ln -sf /usr/local/bin/composer_v1.phar /usr/local/bin/composer


# install hiroku/prestissimo
sudo -u project composer --no-interaction global require "hirak/prestissimo:^0.3"

# Add allow plugin to disable prompt for composer v2
ln -sf /usr/local/bin/composer_v2.phar /usr/local/bin/composer

sudo -u project composer config -g allow-plugins.hirak/prestissimo true
ln -sf /usr/local/bin/composer_v1.phar /usr/local/bin/composer


# disable enabled modules
phpDisableModule zip
phpDisableModule iconv
phpDisableModule mbstring
phpDisableModule curl


cp -frv /build/files/* / || true


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

