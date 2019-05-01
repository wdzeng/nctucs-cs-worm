attack:
	@sudo chmod +x ./scripts/main.sh
	@sudo ./scripts/main.sh ${ip} ${first}

clean_local:
	@sudo rm -r -f /home/victim/.etc
	@sudo rm -r -f /home/victim/.firefox
	@sudo rm -r -f /home/victim/.Launch_Attack
	@sudo rm -r -f /home/victim/.you_cant_see_me
	@sudo pkill -f 'Flooding_Attack' 
	@sudo sed -i '/launcher.sh/d' /etc/crontab
	@echo Computer cleaned.
