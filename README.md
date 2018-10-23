# lms-gd

Logitech Media Server in a Gentoo Docker container

Install via ebuild in the [lmiphay](https://cgit.gentoo.org/user/lmiphay.git/) overlay.

The ebuild is: [lms-gd](https://cgit.gentoo.org/user/lmiphay.git/tree/media-sound/lms-gd)

```
$ lms-gd
Usage: lms-gd {init|create|start|stop|restart|shell|status}

       lms-gd init
       lms-gd build [<image_name>]
       lms-gd create [<music_dir> <image_name> <container_name>]
       lms-gd start [<container_name>]
       lms-gd stop [<container_name>]
       lms-gd restart [<container_name>]

Settings:

  music_dir=/mnt/music (music location on host)
  image_name=gentoo/lms:latest (un-runnable immutable base for container)
  container_name=lms (runnable instance of the image)
```

# Quickstart

First some generic docker bits:

* setup Docker on gentoo - see: [https://wiki.gentoo.org/wiki/Docker](https://wiki.gentoo.org/wiki/Docker)
* docker pull gentoo/stage3-amd64:latest
* docker pull gentoo/portage:latest

Now install lms-gd and get ready to create an lms container:

* layman -a lmiphay && emerge lms-gd
* mkdir /var/tmp/lms-gd-build-area
* cd /var/tmp/lms-gd-build-area
* lms-gd init

Now examine/change the contents of the files in: /var/tmp/lms-gd-build-area

Now build the image, create an lms container and finally start it:

* lms-gd build
* lms-gd create
* lms-gd start

# OpenRC

* rc-config add lms-gd
* [optional] change container name in /etc/conf.d/lms-gd
* /etc/init/lms-gd start

# Todo

+ set /mnt/music in /etc/logitechmediaserver/server.prefs
+ install logrotate (see /etc/logrotate.d/logitechmediaserver)
+ install cronie (see above)
+ install syslog
+ setup (normal - not docker style) bridged networking to support castbridge/shairport)
+ script removal RESTRICT="bindist mirror" in ebuild and rebuild manifest
+ documentation
+ add a unit file

# Prior Art

+ [docker-logitechmediaserver](https://github.com/justifiably/docker-logitechmediaserver) (and many forks)
