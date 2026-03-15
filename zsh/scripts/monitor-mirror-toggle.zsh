function toggle_monitor_mirror() {
  TARGET="HDMI-A-1"
  SOURCE="eDP-1"

  hyprctl keyword monitor "$TARGET,preferred,auto,1,mirror,$SOURCE"
}
