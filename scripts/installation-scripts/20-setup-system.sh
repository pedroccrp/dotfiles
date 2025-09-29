if [ $(id -u) -ne 0 ]
  then echo Please run this script as root or using sudo!
  exit
fi

# Audio
# https://wiki.archlinux.org/title/Sound_system
echo "Unmuting audio..."
amixer sset Master unmute &>/dev/null
amixer sset Speaker unmute &>/dev/null
amixer sset Headphone unmute &>/dev/null

# Bluetooth
echo "Starting bluetooth services..."
systemctl enable bluetooth
systemctl start bluetooth

sudo systemctl enable docker.service
sudo usermod -aG docker $USER
