function toggle_monitor_mirror() {
  TARGET="HDMI-A-1"
  SOURCE="eDP-1"

  STATE=$(hyprctl monitors -j | jq -r ".[] | select(.name==\"$TARGET\") | .mirrorOf")

  if hyprctl monitors | grep -A5 "$TARGET" | grep -q "mirroring: $SOURCE"; then
    hyprctl keyword monitor "DP-1,1920x1080@60,0x0,1"
    hyprctl keyword monitor "$TARGET,1920x1080@60,1920x0,1"
  else
    hyprctl keyword monitor "$TARGET,mirror,$SOURCE"
  fi
}
