## Oxid starter image (php5.6 version)

### Description
This image is a dev image style, used with oxid src volumes to automatically add composer to oxid, install NFQ oxid modules and run them. It is a good start up point for module development or testing modules with multiple oxid versions

### Oxid versions supported
This image has a lower oxid version requirement of __v4.7.5__

### Environment variables
* __NFQ_ENABLE_PHP_MODULES__: See [php5x-cli image](../php56-cli)
* __NFQ_PROJECT_ROOT__: Should point to modules directory in src volume, typically `/home/project/src/www/web/modules`
* __NFQ_REQUIRE_MODULES__: Space separated list of oxid modules to install via composer
	* It supports composer notation, __WARNING__ don't use space between module and version
	* If version info is omitted `dev-develop` is used by default
	* example: `nfq/module-1:dev-develop nfq/module-2`
* __NFQ_COMPOSER_REPOS__: Space separated list of custom repositories for composer
	* Notation is "repo_name|git@git.host.tld:repo.git"
	* __repo_name__ is uniqe id for composer internal repositories list 

