# lms-gd

Logitech Media Server in a Gentoo Docker container

Install via ebuild in the [lmiphay](https://cgit.gentoo.org/user/lmiphay.git/) overlay.

The ebuild is: [lms-gd](https://cgit.gentoo.org/user/lmiphay.git/tree/media-sound/lms-gd)

# Todo

+ set /mnt/music in /etc/logitechmediaserver/server.prefs
+ install logrotate (see /etc/logrotate.d/logitechmediaserver)
+ install cronie (see above)
+ install syslog
+ setup (normal - not docker style) bridged networking to support castbridge/shairport)
+ script removal RESTRICT="bindist mirror" in ebuild and rebuild manifest


