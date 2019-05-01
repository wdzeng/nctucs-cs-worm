task1:
	@sudo chmod +x ./task_i/script.sh
	@sudo ./task_i/script.sh

task2:
	@sudo chmod +x ./task_ii/script.sh
	@sudo ./task_ii/script.sh

task2_clean:
	@sudo rm -r -f /home/victim/.etc
	@sudo rm -r -f /home/victim/.firefox
	@sudo rm -r -f /home/victim/.Launch_Attack
	@sudo rm -r -f /home/victim/.you_cant_see_me
	@sudo pkill -f 'Flooding_Attack' 
	@sudo sed -i '/launcher.sh/d' /etc/crontab
	@echo Computer cleaned.

task3_victim:
	@sudo chmod +x ./task_iii_victim/script.sh
	@sudo ./task_iii_victim/script.sh
