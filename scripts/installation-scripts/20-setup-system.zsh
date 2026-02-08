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

# Laptop lid closing behavior
sudo awk '
BEGIN { lid=0; ac=0; dock=0 }
{
  if ($0 ~ /^[[:space:]]*#?[[:space:]]*HandleLidSwitch=/) {
    print "HandleLidSwitch=lock"; lid=1; next
  }
  if ($0 ~ /^[[:space:]]*#?[[:space:]]*HandleLidSwitchExternalPower=/) {
    print "HandleLidSwitchExternalPower=lock"; ac=1; next
  }
  if ($0 ~ /^[[:space:]]*#?[[:space:]]*HandleLidSwitchDocked=/) {
    print "HandleLidSwitchDocked=ignore"; dock=1; next
  }
  print
}
END {
  if (!lid)  print "HandleLidSwitch=lock"
  if (!ac)   print "HandleLidSwitchExternalPower=lock"
  if (!dock) print "HandleLidSwitchDocked=ignore"
}
' /etc/systemd/logind.conf | sudo tee /etc/systemd/logind.conf >/dev/null
