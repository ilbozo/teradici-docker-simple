FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
ENV TZ=Etc/UTC
RUN apt -y update
RUN apt -y upgrade
RUN apt install -y curl sudo
RUN apt -y install tzdata keyboard-configuration
RUN curl -1sLf https://dl.teradici.com/DeAdBCiUYInHcSTy/pcoip-client/cfg/setup/bash.deb.sh | sudo -E distro=ubuntu codename=focal bash
RUN apt install -y gnupg apt-transport-https
RUN apt install -y pcoip-client
RUN apt install -y libmfx1 libmfx-tools libva-drm2 libva-x11-2 vainfo intel-media-va-driver-non-free
# sound
RUN apt install -y --no-install-recommends alsa-base alsa-utils libsndfile1-dev && apt clean



RUN export PUID=1000 PGID=1000 && \
    mkdir -p /etc/sudoers.d/ && \
    mkdir -p /home/teradici && \
    echo "teradici:x:${PUID}:${PGID}:teradici,,,:/home/teradici:/bin/bash" >> /etc/passwd && \
    echo "teradici:x:${PUID}:" >> /etc/group && \
    echo "teradici ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/teradici && \
    chmod 0440 /etc/sudoers.d/teradici && \
    chown ${PUID}:${PGID} -R /home/teradici



## Set some environment variables for the current user
USER teradici
ENV HOME /home/teradici

## Set the path for QT to find the keyboard context
ENV QT_XKB_CONFIG_ROOT /user/share/X11/xkb
#
ADD entrypoint.sh /usr/bin/
ENTRYPOINT exec /usr/bin/entrypoint.sh
