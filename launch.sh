#!/bin/bash

if [[ $1 = 'run' ]]; then
    docker run -it --privileged --rm \
        -e DISPLAY=$DISPLAY \
        --net=host \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -v /root/.Xauthority:/root/.Xauthority:rw \
        -v $(pwd)/node_modules:/home/pptruser/worker/node_modules \
        puppeteer
elif [[ $1 = 'build' ]]; then
    docker build \
        --rm \
        -t \
        puppeteer \
        .
else
    echo "usage: ./launch.sh run|build"
fi;