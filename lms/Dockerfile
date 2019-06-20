# image is based on stage3-amd64 - see:
#  1. https://github.com/gentoo/gentoo-docker-images
#  2. https://hub.docker.com/r/gentoo/stage3-amd64/tags/
#  3. https://hub.docker.com/r/gentoo/portage/tags/

FROM gentoo/stage3-amd64:latest

# 3483 TCP/UDP client players
# 9000 TCP web console
# 9090 CLI interaction
# 31337 firmware updates
# 42459
EXPOSE 3483/tcp 3483/udp 9000 9090

ARG MIRROR
ARG VERSION

WORKDIR /etc
RUN echo rc_provide="net" >>rc.conf

WORKDIR /etc/portage
RUN echo -e "GENTOO_MIRRORS=${MIRROR}\nACCEPT_LICENSE=logitechmediaserver-bin" >>make.conf
RUN echo "dev-lang/perl ithreads" >>package.use
RUN echo "=media-sound/logitechmediaserver-bin-${VERSION} ~amd64" >>package.keywords

WORKDIR /etc/portage/repos.conf
RUN echo -e "[squeezebox]\nlocation = /usr/local/squeezebox.repo\nauto-sync = no" >squeezebox.conf

COPY squeezebox.repo /usr/local/
COPY install.sh sysklogd-disable-klogd.patch /root/

VOLUME /mnt/music

ENTRYPOINT [ "/sbin/init" ]
