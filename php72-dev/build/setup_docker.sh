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
curl -sSL 'https://getcomposer.org/download/1.10.24/composer.phar' > /usr/local/bin/composer.phar
chmod a+x /usr/local/bin/composer.phar
ln -s /usr/local/bin/composer.phar /usr/local/bin/composer
composer self-update --1


# installl hiroku/prestissimo
phpEnableModule curl
sudo -u project composer --no-interaction global require "hirak/prestissimo:^0.3"


# disable enabled modules
phpDisableModule curl
phpDisableModule json
phpDisableModule phar
phpDisableModule zip


# install phpunit
phpEnableModule phar
curl -sSL 'https://phar.phpunit.de/phpunit-6.5.9.phar' > /usr/local/bin/phpunit.phar
chmod a+x /usr/local/bin/phpunit.phar
ln -s /usr/local/bin/phpunit.phar /usr/local/bin/phpunit


cp -frv /build/files/* /


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh

