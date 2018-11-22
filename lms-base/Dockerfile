# syntax = tonistiigi/dockerfile:runmount20180618
#
# Requires Docker v18.06 with `DOCKER_BUILDKIT=1` (see: https://github.com/moby/moby/issues/32507)
# docker daemon needs to started with --experimental or the Experimental config
#

# image is based on stage3-amd64 - see:
#  1. https://github.com/gentoo/gentoo-docker-images
#  2. https://hub.docker.com/r/gentoo/stage3-amd64/tags/
#  3. https://hub.docker.com/r/gentoo/portage/tags/

FROM gentoo/portage:latest as portage
FROM gentoo/stage3-amd64:latest

WORKDIR /etc/portage

COPY perl.use package.use
COPY mirrors.make.conf .

RUN \
	--mount from=portage,src=/usr/portage,dst=/usr/portage \
	\
	cat mirrors.make.conf >>make.conf && \
	echo rc_provide="net" >>/etc/rc.conf && \
	\
	emerge \
	    app-admin/logrotate \
	    app-admin/sysklogd \
	    dev-lang/perl \
	    sys-process/cronie \
	    && \
	\
	perl-cleaner --modules && \
	perl-cleaner --force --libperl && \
	\
	rc-update add cronie default && \
	rc-update add sysklogd default

# syslogd (could alternaitvely bind mount in /dev/log)
# don't start/stop klogd - TODO patch via /etc/portage/patches/media-sound/lms-gd (possible?)
COPY sysklogd.rc7 /etc/init.d

ENTRYPOINT [ "/sbin/init" ]
