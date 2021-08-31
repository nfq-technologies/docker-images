#!/bin/bash
set -e

init-git-flow() {
	sudo -u project git config --local --unset core.fileMode
	sudo -u project git checkout -b master origin/master  || sudo -u project git checkout master || sudo -u project git branch master
	sudo -u project git checkout -b develop origin/develop || sudo -u project git checkout develop || sudo -u project git branch develop
	sudo -u project git flow init -fd
	sudo -u project git checkout "${1}"
}

phpEnableModule()
{
	if type phpenmod &> /dev/null; then
		phpenmod -v ALL -s ALL "$1"
	else
		if php -v | grep -q "PHP 5."; then
			php5enmod "$1"
		else
			php5enmod -s ALL "$1"
		fi
	fi
}

phpDisableModule()
{
	if type phpdismod &> /dev/null; then
		phpdismod -v ALL -s ALL "$1"
	else
		if php -v | grep -q "PHP 5."; then
			php5dismod "$1"
		else
			php5dismod -s ALL "$1"
		fi
	fi
}

