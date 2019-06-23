# image is based on stage3-amd64 - see:
#  1. https://github.com/gentoo/gentoo-docker-images
#  2. https://hub.docker.com/r/gentoo/stage3-amd64/tags/

FROM gentoo/stage3-amd64:latest

# 3483 TCP/UDP client players
# 9000 TCP web console
# 9090 CLI interaction
# 31337 firmware updates
# 42459
EXPOSE 3483/tcp 3483/udp 9000 9090

ARG MIRROR

WORKDIR /etc
RUN echo rc_provide="net" >>rc.conf

WORKDIR /etc/portage/repos.conf
RUN echo -e "[squeezebox]\nlocation = /usr/local/squeezebox.overlay\nauto-sync = no" >squeezebox.conf

COPY squeezebox.overlay /usr/local/squeezebox.overlay
COPY logitechmediaserver.etc /root/logitechmediaserver.etc
COPY Makefile.container sysklogd-disable-klogd.patch /root/

VOLUME /mnt/music

ENTRYPOINT [ "/sbin/init" ]
