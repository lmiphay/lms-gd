#!/sbin/openrc-run
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

description="Logitech Media Server in a Gentoo Docker container"

depend() {
    need net docker
}

start() {
    local container="${LMS_GD_CONTAINER:-lms}"

    ebegin "Starting Logitech Media Server container $container"
    docker start "$container"
    eend $?

    if [ -n "${LMS_GD_IP_ADDRESS}" ] ; then
	ebegin "Add public IP to Logitech Media Server container $container"
	count=0
	until [ "$(docker inspect -f {{.State.Running}} $container)" == "true" ] ; do
	    sleep 0.3;
	    let count+=1
	    if [ $count -eq 30 ] ; then
		echo "Failed to run container $container"
		break
	    fi
	done
	docker-link start "$container" "${LMS_GD_IP_ADDRESS}"
	eend $?
    fi
}

stop() {
    local container="${LMS_GD_CONTAINER:-lms}"

    if [ -n "${LMS_GD_IP_ADDRESS}" ] ; then
	ebegin "Removing public IP from Logitech Media Server container $container"
	docker-link stop "$container"
	eend $?
    fi

    ebegin "Stopping Logitech Media Server container $container"
    docker stop -t 10 "$container" # wait 10 seconds for the container to stop before killing it
    eend $?
}
