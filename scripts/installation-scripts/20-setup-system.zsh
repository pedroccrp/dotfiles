if (( EUID != 0 )); then
  sudo -v || return 1
fi

# Audio
# https://wiki.archlinux.org/title/Sound_system
echo "Unmuting audio..."
sudo amixer sset Master unmute &>/dev/null
sudo amixer sset Speaker unmute &>/dev/null
sudo amixer sset Headphone unmute &>/dev/null

# Bluetooth
echo "Starting bluetooth services..."
sudo systemctl enable bluetooth
sudo systemctl start bluetooth

sudo systemctl enable docker.service
sudo usermod -aG docker $USER

sudo systemctl enable ly@tty2.service
sudo systemctl start ly@tty2.service

sudo ufw default deny
sudo ufw enable
