#!/sbin/openrc-run
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

description="Logitech Media Server in a Gentoo Docker container"

command="/usr/bin/docker"
command_args="start ${LMS_GD_CONTAINER:-lms}"

command_background=yes
pidfile=/run/docker-lms.pid

depend() {
    need net
    use alsasound
    after bootmisc
}
