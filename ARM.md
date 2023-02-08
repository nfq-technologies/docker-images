# Building arm images

Requirements: ARM machine with docker installed and your ssh key added.

docker context update arm --docker=host=ssh://USER@HOST
DOCKER_CONTEXT=arm docker login

After that, you can run `make all` on nfqlt/dev!
