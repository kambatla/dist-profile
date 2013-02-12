#!/bin/bash -xe

die() {
    echo $@
    exit 1
}

[ $EUID == 0 ] || die "you must run this script as root"
echo 3 > /proc/sys/vm/drop_caches

/sbin/blockdev --setra 16384 /dev/fioa /dev/sd*

killall -q python
