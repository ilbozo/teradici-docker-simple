#!/bin/bash
user_id=$(id -u)
group_id=$(id -g)
NVIDIA_DRIVER_CAPABILITIES="all"
mkdir -p ~/.config/Teradici/.logs
mkdir -p ~/.config/Teradici/.config
mkdir -p ~/.config/Teradici/.config/pulse
xhost +local:docker

if command -v nvidia-smi
then
    docker run -it \
        --gpus=all \
        --privileged \
        --cap-add=NET_ADMIN \
        --device /dev/net/tun \
        --device /dev/snd \
        --rm \
        -v ~/.config/Teradici:/home/teradici/.config/Teradici \
        -v ~/.logs/Teradici:/tmp/Teradici/teradici/PCoIPClient/logs \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY="$DISPLAY" \
        pcoip-client
else
    docker run -it \
        --privileged \
        --cap-add=NET_ADMIN \
        --device /dev/net/tun \
        --device /dev/snd \
        --rm \
        -v ~/.config/Teradici:/home/teradici/.config/Teradici \
        -v ~/.logs/Teradici:/tmp/Teradici/teradici/PCoIPClient/logs \
        -v /tmp/.X11-unix:/tmp/.X11-unix \
        -e DISPLAY="$DISPLAY" \
        pcoip-client
fi
