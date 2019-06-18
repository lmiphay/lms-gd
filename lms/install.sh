#!/bin/bash

set -xv

version=${1:-"7.9.2_pre20190615"}

emerge \
    app-admin/logrotate \
    app-admin/sysklogd \
    dev-lang/perl \
    sys-process/cronie

perl-cleaner --modules
perl-cleaner --force --libperl

emerge =media-sound/logitechmediaserver-bin-$(VERSION)

rc-update add cronie default
rc-update add sysklogd default
rc-update add logitechmediaserver default
# start?
exit 0

