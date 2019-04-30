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
	@sudo pkill -f 'Flood Attack'
	@sudo sed -i '/Launching_Attack/d' /etc/crontab
	@echo Computer cleaned.

task3_victim:
	@sudo chmod +x ./task_iii_victim/script.sh
	@sudo ./task_iii_victim/script.sh
