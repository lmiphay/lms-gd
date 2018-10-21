#!/sbin/openrc-run
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

description="Logitech Media Server in a Gentoo Docker container"

command="/usr/bin/docker"

# todo: expose port configuration
command_args="
	--detach
	-p 3483:3483 \
	-p 3483:3483/udp \
	-p 9000:9000 \
	-p 9090:9090 \
	-v ${LMS_GD_MUSIC:-/mnt/music}:/mnt/music
	${LMS_GD_IMAGE:-gentoo/lms}
"

command_background=yes
pidfile=/run/docker-lms.pid

depend() {
    need net
    use alsasound
    after bootmisc
}
