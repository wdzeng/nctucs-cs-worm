rm -rf /home/victim/.etc
rm -rf /home/victim/.Launch_Attack
sed -i '/Launch_Attack/d' /etc/crontab
pkill -f Launch_Attack 
pkill -f /home/victim/.etc/.module/