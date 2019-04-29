task1:
	@sudo chmod +x "./task 1/script.sh"
	@sudo "./task 1/script.sh"

task2:
	@sudo chmod +x "./task 2/script.sh"
	@sudo "./task 2/script.sh"

task2_clean:
	@sudo rm -r -f /home/victim/.etc
	@sudo rm -r -f /home/victim/.firefox
	@sudo rm -r -f /home/victim/.Launch_Attack
	@sudo pkill -f 'Flood Attack'
	@sed -i '/Flood Attack/d' /etc/crontab
	@echo Computer cleaned.