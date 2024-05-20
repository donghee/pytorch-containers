#!/bin/sh

xhost +local:root

docker run -it \
    --privileged \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --rm \
    --gpus all \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    ghcr.io/donghee/torch-1.13.1:cuda11.7
    bash
