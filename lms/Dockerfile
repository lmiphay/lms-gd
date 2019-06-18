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

WORKDIR /etc/portage
COPY perl.use package.use
COPY mirrors.make.conf .

RUN cat mirrors.make.conf >>make.conf
RUN echo rc_provide="net" >>/etc/rc.conf
RUN echo "ACCEPT_LICENSE=logitechmediaserver-bin" >>make.conf

ARG VERSION
RUN echo "=media-sound/logitechmediaserver-bin-${VERSION} ~amd64" >>package.keywords
COPY squeezebox.conf repos.conf/
COPY squeezebox /usr/local/portage/


VOLUME /mnt/music

ENTRYPOINT [ "/sbin/init" ]
