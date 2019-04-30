#!/bin/bash
# This script is to:
# (1) Kill the running worm programs
# (2) Delete the worm binary files in this computer
# (3) Fix crontab

rm -rf /home/victim/.etc
rm -rf /home/victim/.Launch_Attack
sed -i '/Launch_Attack/d' /etc/crontab
pkill -f Launch_Attack 
pkill -f /home/victim/.etc/.module/
echo Computer cleaned