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
    emerge sys-process/cronie app-admin/logrotate media-sound/logitechmediaserver-bin && \
    perl-cleaner --modules && \
    perl-cleaner --force --libperl && \
    rc-update add logitechmediaserver default && \
    rc-update add cronie default && \
    rm -rf /usr/portage

COPY --chown=logitechmediaserver logitechmediaserver /etc/logitechmediaserver

# add syslogd (alternatively bind mount in /dev/log)
RUN emerge app-admin/sysklogd && \
    rc-update add sysklogd default
# don't start/stop klogd - TODO patch via /etc/portage/patches/media-sound/lms-gd (possible?)
COPY sysklogd.rc7 /etc/init.d

VOLUME /mnt/music

ENTRYPOINT [ "/sbin/init" ]
