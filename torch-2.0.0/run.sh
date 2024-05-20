#!/bin/sh

xhost +local:root

docker run -it \
    --privileged \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    -p 8888:8888 \
    --rm \
    --gpus all \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    ghcr.io/donghee/torch-2.0.0:cuda11.7 \
    jupyter notebook --ip 0.0.0.0 --allow-root
