#!/bin/bash
docker run -it --platform linux/amd64 --rm \
                -v ${PWD}:/home/project/images/nfqlt:rw \
                nfqlt/php74-cli \
                bash -c '\
                    phpenmod gv ;\
                    /home/project/images/nfqlt/_tools/graph-gen.php' ;
