FROM ubuntu:19.10
RUN apt-get update -y
RUN apt-get install -y \
    firefox \
    libxxf86vm1 \
    libglu1-mesa \
    libopenal1
ADD libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb /tmp/.
RUN apt install -f /tmp/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
RUN rm -f /tmp/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/player && \
    mkdir -p /etc && \
    mkdir -p /etc/sudoers.d/ && \
    echo "player:x:${uid}:${gid}:player,,,:/home/player:/bin/bash" >> /etc/passwd && \
    echo "player:x:${uid}:" >> /etc/group && \
    echo "player ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/player && \
    chmod 0440 /etc/sudoers.d/player && \
    chown ${uid}:${gid} -R /home/player
USER player
ENV HOME /home/player
WORKDIR /home/player
CMD bash
