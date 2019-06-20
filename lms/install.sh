#!/bin/bash

set -xv

version=${1:-"7.9.2_pre20190615"}

emerge \
    app-admin/logrotate \
    app-admin/sysklogd \
    dev-lang/perl \
    sys-process/cronie

patch -p 1 --directory=/etc/init.d </root/sysklogd-disable-klogd.patch

perl-cleaner --modules
perl-cleaner --force --libperl

emerge =media-sound/logitechmediaserver-bin-$(VERSION)

if [ ! -f /etc/logitechmediaserver/server.prefs ] ; then
    cp -upvr /root/logitechmediaserver.etc/ /etc/logitechmediaserver/
    sed -i '/^mediadirs:/{n;s:.*:- /mnt/media:}' /etc/logitechmediaserver/server.prefs
    chown -R logitechmediaserver:logitechmediaserver /etc/logitechmediaserver
fi

for service in cronie sysklogd ; do
    rc-update add $service default
    /etc/init.d/$service start
done

exit 0

