#!/sbin/openrc-run
# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

description="Logitech Media Server in a Gentoo Docker container"
logfile="/var/log/lms-gd.log"

container="${LMS_GD_CONTAINER:-lms}"

lmsgd_log()
{
    echo "$(date '+%Y%m%d:%H:%M:%S'): $@" >>$logfile
}

wait_up()
{
    local count=0

    until [ "$(docker inspect -f {{.State.Running}} $container)" == "true" ] ; do
	sleep 1.0;
	let count+=1
	if [ $count -eq "${LMS_GD_STARTUP_WAIT:-20}" ] ; then
	    lmsgd_log "Failed to start container $container"
	    return 1
	fi
    done

    lmsgd_log "Container $container started in $count seconds"

    return 0
}

depend() {
    need net docker
}

start() {
    ebegin "Starting Logitech Media Server container $container"
    docker start "$container"
    lmsgd_log "started $container: $(docker ps -f name=$container|tail -1)"
    eend $?

    if [ -n "${LMS_GD_IP_ADDRESS}" ] ; then
	if wait_up ; then
	    ebegin "Add public IP to Logitech Media Server container $container"
	    docker-link start "$container" "${LMS_GD_IP_ADDRESS}"
	    eend $?
	fi
    fi
}

stop() {
    if [ -n "${LMS_GD_IP_ADDRESS}" ] ; then
	ebegin "Removing public IP from Logitech Media Server container $container"
	docker-link stop "$container"
	eend $?
    fi

    ebegin "Stopping Logitech Media Server container $container"
    lmsgd_log "stopping $container: $(docker ps -f name=$container|tail -1)"
    docker stop -t 10 "$container" # wait 10 seconds for the container to stop before killing it
    eend $?
}
