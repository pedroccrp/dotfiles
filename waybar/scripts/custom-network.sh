#!/bin/bash

interface=$(ip route | awk '/default/ {print $5}' | head -n1)
ssid=$(iw dev "$interface" link | awk -F ': ' '/SSID/ {print $2}')
signal=$(awk '/^\s*w/ { print int($3 * 100 / 70) }' /proc/net/wireless)
ip=$(ip addr show "$interface" | awk '/inet / {print $2}' | cut -d/ -f1)

if [[ $signal -ge 80 ]]; then icon="󰤨"
elif [[ $signal -ge 60 ]]; then icon="󰤥"
elif [[ $signal -ge 40 ]]; then icon="󰤢"
elif [[ $signal -ge 20 ]]; then icon="󰤟"
else icon="󰤯"; fi

if [[ -z "$ssid" ]]; then
  echo '{"text": "󰤭  Disconnected", "tooltip": "No Wi-Fi connection"}'
  exit 0
fi

ping_output=$(ping -c 1 -W 1 8.8.8.8 2>/dev/null)
ping_time=$(echo "$ping_output" | awk -F'=' '/time=/{print $4}' | cut -d' ' -f1)

if [[ -z "$ping_time" ]]; then
  echo "{\"text\": \"$icon No Internet)\", \"tooltip\": \"SSID: $ssid\nIP: $ip\nSignal: $signal%\n(No internet connection)\"}"
else
  echo "{\"text\": \"$icon \", \"tooltip\": \"SSID: $ssid\nIP: $ip\nSignal: $signal%\nPing: $ping_time ms\"}"
fi
