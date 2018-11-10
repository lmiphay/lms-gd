# lms-gd : Logitech Media Server in a Gentoo Docker container

This project allows Logitech Media Server to be run inside a Gentoo Docker container, in turn running on a Gentoo host.

Currently this project can be installed via the [lms-gd](https://cgit.gentoo.org/user/lmiphay.git/tree/media-sound/lms-gd) ebuild in the [lmiphay](https://cgit.gentoo.org/user/lmiphay.git/) overlay.

# Usage

The lms-gd management program can be used to:
+ build images, and createstart/stop containers
+ start a shell on a running container
+ backup the configuration of a running container


```
$ lms-gd
Usage: lms-gd {init|create|start|stop|restart|shell|status|backup}

       lms-gd init
       lms-gd build [<image_name>]
       lms-gd create [<music_dir> <image_name> <container_name>]
       lms-gd start [<container_name>]
       lms-gd stop [<container_name>]
       lms-gd restart [<container_name>]
       lms-gd shell [<container_name>]
       lms-gd status
       lms-gd backup [<container_name>]
       lms-gd bridge [<container_name> <bridge_name> <ip_address> <broadcast_address> <router_address>]

Settings:

  music_dir=/mnt/music (music location on host)
  image_name=gentoo/lms:latest (un-runnable immutable base for container)
  container_name=lms (runnable instance of the image)
$
```

# Quickstart

First some generic docker steps:

* setup Docker on gentoo - see: [https://wiki.gentoo.org/wiki/Docker](https://wiki.gentoo.org/wiki/Docker)
* check the new kernel configuration using e.g.: `/usr/share/docker/contrib/check-config.sh /usr/src/linux/.config`
* `docker pull gentoo/stage3-amd64:latest`
* `docker pull gentoo/portage:latest`

Install lms-gd and prepare to create an lms container:

* `layman -a lmiphay && emerge lms-gd`
* `mkdir /var/tmp/lms-gd-build-area`
* `cd /var/tmp/lms-gd-build-area`
* `lms-gd init`

`lms-gd init` creates a context for the subsequent image build by:

* copying Dockerfile and portage configuration files from /usr/share/lms-gd (if not already present)
* git cloning the `squeezebox` overlay (if not already present) and remove RESTRICT lines from the ebuilds
* copies the contents of /etc/logitechmediaserver

Examine/change the contents of the files in: /var/tmp/lms-gd-build-area

Check that the first element of the mediadirs array in logitechmediaserver/server.prefs has been set to: /mnt/music

Now build the image, create an lms container and finally start it:

* `lms-gd build`
* `lms-gd create`
* `lms-gd start`

# Customisation

After `lms-gd init` is run, useful customisations include:

+ add/remove packages in the Dockerfile, make other adjustments to the image.
+ adjust keywords in lms.keywords to select which version of logitechmediaserver-bin is installed.
+ add a local mirror to make.conf.lms-gd - e.g. GENTOO_MIRRORS="http://192.168.1.42/gentoo http://distfiles.gentoo.org"

lms-gd operation is controlled by these variables - listed here with defaults:

+ `LMS_GD_MUSIC="/mnt/music"`           (location of music directory to mount from the host)
+ `LMS_GD_IMAGE="gentoo/lms:latest"`    (the name of the image created by `lms-gd build`)
+ `LMS_GD_CONTAINER="lms"`              (the name of the container created by `lms-gd create`)
+ `LMS_GD_STARTUP_WAIT=20`              (how long to wait on startup for the contiainer to be in the running state)
+ `LMS_GD_IP_ADDRESS=""`                (the IP address to be assigned in bridged mode)

# OpenRC

To have the host start the container:

* `rc-config add lms-gd`
* [optional] change container name in /etc/conf.d/lms-gd
* [optional] set public IP address in /etc/conf.d/lms-gd
* [optional] set startup-wait in /etc/conf.d/lms-gd
* `/etc/init/lms-gd start`

# Todo

+ setup normal (not docker style) [bridged networking](https://github.com/lmiphay/docker-link) to support castbridge/shairport
+ [reduce the size of the image (DOCKER_BUILDKIT=1 on 18.06)](https://github.com/moby/moby/issues/32507#issuecomment-409092581)
+ bindfs the container filesystem

# Versions

+ 0.2 TBR
  * add cron, syslog, logrotate to image
  * support bridged n/w
  * add backup support to lms-gd
  * set mediadir in server.prefs
  * script removal RESTRICT="bindist mirror" in ebuild and rebuilds manifest
  * added a unit file (to manage the service on the host)
+ 0.1 initial proof of concept

# Prior Art/Related Information/References

+ [docker-logitechmediaserver](https://github.com/justifiably/docker-logitechmediaserver) (and many forks)
+ https://hub.docker.com/r/larsks/logitech-media-server/
+ https://github.com/jgoerzen/docker-logitech-media-server
+ https://forum.qnap.com/viewtopic.php?f=354&t=123933
+ https://www.eddgrant.com/blog/2016/07/07/running-logitech-media-server-in-docker.html
+ https://forums.slimdevices.com/showthread.php?108312-Providing-Official-Docker-Image
