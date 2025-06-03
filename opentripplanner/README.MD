# OpenTripPlanner Docker Image

This repository contains a Docker setup for running OpenTripPlanner, a multi-modal trip planner supporting different modes of transport.

## Overview

This Docker image is based on the official OpenTripPlanner image and includes additional setup scripts to configure the environment. The Java heap size is set to 4GB.

## Compose Example

opentripplanner:
    image: nfqlt/opentripplanner
    volumes:
      - './src/tools/opentripplanner/data:/var/opentripplanner:rw'
      - './conf.d/init.sh:/init.sh:ro'
    entrypoint: []
    command: '/init.sh'
    ports:
      - '10.24.1.1:8080:8080'

## Init Script Example

#!/bin/bash

set -ex

cd /var/opentripplanner

if [ ! -f graph.obj ]; then
    if [ ! -f streetGraph.obj ]; then
        wget https://download.geofabrik.de/europe/lithuania-latest.osm.pbf -nv -O osm.pbf

        /docker-entrypoint.sh --buildStreet
    fi

    wget https://www.visimarsrutai.lt/gtfs/AkmenesR.zip -nv -O AkmenesR.gtfs.zip &
    wget https://www.visimarsrutai.lt/gtfs/AlytausM.zip -nv -O AlytausM.gtfs.zip &
    wget https://www.visimarsrutai.lt/gtfs/AlytausR.zip -nv -O AlytausR.gtfs.zip &
    wget https://www.visimarsrutai.lt/gtfs/ZarasuR.zip -nv -O ZarasuR.gtfs.zip &
    wait

    /docker-entrypoint.sh --loadStreet --save
fi

/docker-entrypoint.sh --load --serve

## Note: init.sh must be executable.
