#!/sbin/openrc-run
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

description="Logitech Media Server in a Gentoo Docker container"

depend() {
    need net docker
}

start() {
    ebegin "Starting Logitech Media Server container"
    docker start "${LMS_GD_CONTAINER:-lms}"
    eend $?
}

stop() {
    ebegin "Stopping Logitech Media Server container"
    docker stop "${LMS_GD_CONTAINER:-lms}"
    eend $?
}
