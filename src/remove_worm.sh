if [ -d "/home/victim/.etc" ] || [ -d "/home/victim/.Launch_Attack" ]; then 
    rm -rf /home/victim/.etc && rm -rf /home/victim/.Launch_Attack && echo "Worm binary files deleted." || echo "Failed to delete the worm binary files."
else 
    echo "Worm not found."
fi
