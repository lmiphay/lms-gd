#!/bin/bash

src_tree="$(realpath $(dirname $0))"
context="/var/tmp/context"

export PATH="${src_tree}:$PATH"

LMS_GD_TEMPLATE="$src_tree/"
LMS_GD_IMAGE="gentoo/lms:test"
LMS_GD_CONTAINER="lms-test"
LMS_GD_BRIDGE="br0"
LMS_GD_IP="192.168.1.17"

export LMS_GD_TEMPLATE LMS_GD_IMAGE LMS_GD_CONTAINER LMS_GD_BRIDGE LMS_GD_IP

[ -d "$context" ] && rm -rf $contest
mkdir -p $context
cd $context

echo -e "Config:\n PATH=$PATH\n src_tree=$src_tree\n context=$context\n\n$(env|grep LMS_GD)\n\n"

steps="version init"
#steps="version init build create start status" # backup bridge

for step in $steps; do
    echo "lms-gd $step -->>"
    lms-gd "$step"
done

exit 0



