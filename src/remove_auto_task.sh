grep -q 'Launch_Attack' /etc/crontab && (
    sed -i '/Launch_Attack/d' /etc/crontab && echo "Crontab fixed." || echo "Failed to fix crontab."
) || echo "Crontab is not effeceted."
