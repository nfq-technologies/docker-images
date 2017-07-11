#!/bin/bash

set +x


exec /usr/bin/socat TCP4-LISTEN:${NFQ_ROUTER_LOCAL_PORT},fork TCP4:${NFQ_ROUTER_REMOTE_HOST}:${NFQ_ROUTER_REMOTE_PORT}


