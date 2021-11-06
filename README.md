install systemctl
do:
sudo usermod -aG input $(whoami)
sudo usermod -aG video $(whoami)
reboot

setup cron with
crontab -e
\*/15 * * * * bash ~/.scripts/weather.sh

