srcVol:
  image: docker.nfq.lt/projects/oxid_demo_src-data:__OXID_VERSION__
  volumes:
     - /home/project/src

mysql:
  image: docker.nfq.lt/library/mysql:5.5
  volumes_from:
    - mysqlVol

mysqlVol:
  image: docker.nfq.lt/projects/oxid_demo_mysql-data:__OXID_VERSION___mysql5.5
  volumes:
     - /var/lib/mysql

dev:
  image: __STARTER_IMAGE__
  ports:
    - "__PID__:22"
  links:
    - mysql
  volumes:
    - /home/project/.ssh:/home/project/.ssh
    - /etc/ssh:/etc/ssh
    - /etc/gitconfig:/etc/gitconfig
  volumes_from:
    - srcVol
  environment:
    NFQ_ENABLE_PHP_MODULES: curl json gd mysql mysqli
    NFQ_PROJECT_ROOT: /home/project/src/www/web/modules
    NFQ_REQUIRE_MODULES: "nfq/oxid-dummy-module:>=1.0"

