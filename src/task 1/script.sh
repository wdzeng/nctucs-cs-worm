#!/bin/bash
# This script is to:
# (1) Kill the running worm programs
# (2) Delete the worm binary files in this computer
# (3) Fix crontab

res=0

deletedir() {
    if [ -d "$1" ]; then
        rm -rf "$1"
        if [ $? -eq 0 ]; then
            echo "Directory \"$1\" is deleted."
            return 0
        else 
            echo "Deleting directory \"$1\" failed."
            return 1
        fi
    else
        echo "Directory \"$1\" not found."
        return 0;
    fi
}

fixcrontab() {
    if  grep -q /etc/crontab Launch_Attack; then
        sed -i /Launch_Attack/d /etc/crontab
        if [ $? -eq 0 ]; then
            echo "Crontab is fixed."
            return 0
        else
            echo "Failed to fix crontab"
            return 1
        fi
    else
        echo "Crontab is not infected."
        return 0
    fi
}

ures(){
    if [ $? -eq 1 ]; then res=1 fi
}

deletedir /home/victim/.etc
ures
deletedir /home/victim/.Launch_Attack
ures
fixcrontab
ures
pkill -f Launch_Attack 
pkill -f /home/victim/.etc/.module/
res && echo "Computer cleaned" || echo "Failed to fix the computer"