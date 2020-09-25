#!/bin/bash
set -e

source "/tools/common_rc/functions.sh"

GRADLE_VERSION=6.5
ANDROID_SDK_TOOLS="4333796"
ANDROID_COMPILE_SDK="29"
ANDROID_BUILD_TOOLS="29.0.2"

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


apt-get install -y --no-install-recommends openssh-client git git-flow


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


# Java 8
apt-get install -y --no-install-recommends ca-certificates-java openjdk-8-jdk-headless


# Install Android sdkmanager
mkdir /opt/android-sdk-linux
# Because SDK cannot do this itself....
mkdir /home/project/.android/
mkdir /home/project/.android/cache
touch /home/project/.android/repositories.cfg

cd /opt/android-sdk-linux
wget --no-verbose --output-document=sdktools.zip https://dl.google.com/android/repository/sdk-tools-linux-${ANDROID_SDK_TOOLS}.zip
unzip sdktools.zip
rm sdktools.zip
cd -

chown -R project:project /opt/android-sdk-linux
chmod +x /opt/android-sdk-linux/tools/bin/sdkmanager
sudo ln -sf /opt/android-sdk-linux/tools/bin/sdkmanager /usr/local/bin/sdkmanager
echo "export ANDROID_SDK_ROOT=/opt/android-sdk-linux" >> /etc/profile.d/android-env-variable.sh

cp -frv /build/files/* / || true

# Repair user home
chown -R project:project /home/project


# Last step - set up SDK
yes | sudo -u project sdkmanager --update
yes | sudo -u project sdkmanager --licenses
yes | sudo -u project sdkmanager "platforms;android-${ANDROID_COMPILE_SDK}" "platform-tools" "build-tools;${ANDROID_BUILD_TOOLS}" "extras;google;m2repository" "extras;android;m2repository"


# Clean up APT when done.
source /usr/local/build_scripts/cleanup_apt.sh
