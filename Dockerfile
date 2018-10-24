# image is based on stage3-amd64 - see:
#  1. https://github.com/gentoo/gentoo-docker-images
#  2. https://hub.docker.com/r/gentoo/stage3-amd64/tags/
#  3. https://hub.docker.com/r/gentoo/portage/tags/

FROM gentoo/portage:latest as portage
FROM gentoo/stage3-amd64:latest

# 3483 TCP/UDP client players
# 9000 TCP web console
# 9090 CLI interaction
# 31337 firmware updates
# 42459
EXPOSE 3483/tcp 3483/udp 9000 9090

COPY --from=portage /usr/portage /usr/portage
COPY squeezebox /usr/local/portage

WORKDIR /etc/portage

COPY squeezebox.conf repos.conf/
COPY lms.keywords package.keywords
COPY lms.use package.use
COPY make.conf.lms-gd .

RUN cat make.conf.lms-gd >>make.conf && \
    echo rc_provide="net" >>/etc/rc.conf && \
    emerge media-sound/logitechmediaserver-bin && \
    rc-update add logitechmediaserver default && \
    rm -rf /usr/portage

COPY --chown=logitechmediaserver logitechmediaserver /etc/logitechmediaserver

VOLUME /mnt/music

ENTRYPOINT [ "/sbin/init" ]
