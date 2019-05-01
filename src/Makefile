attack:
	@sudo chmod +x ./scripts/main.sh
	@sudo ./scripts/main.sh ${ip} ${first}

victim_reset:
	@sudo rm -rf /home/victim/.etc
	@sudo rm -rf /home/victim/.firefox
	@sudo rm -rf /home/victim/.Launch_Attack
	@sudo rm -rf /home/victim/.you_cant_see_me
	@sudo pkill -f 'Flooding_Attack' 
	@sudo sed -i '/launcher.sh/d' /etc/crontab
	@sudo sed -i '/victim/d' /etc/sudoers
	@sudo rm -rf /tmp/.worm0716023
	@sudo rm -f ~/.ssh/authorized_keys
	@echo Computer cleaned.

attacker_reset:
	@sudo rm -rf ~/.ssh
