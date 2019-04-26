if pgrep "Launch_Attack" || pgrep "/home/victim/.etc/.module/"; then sudo pkill -f Launch_Attack && sudo pkill -f /home/victim/.etc/.module/ && echo "Worm proceesses killed."  || echo "Failed to kill the worm proccesses." 
else
    echo "Worm process not found."
fi