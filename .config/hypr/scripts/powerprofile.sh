#!/bin/bash

# Hardcode the system python and binary paths to bypass pyenv sandboxes
SYS_PYTHON="/usr/bin/python3"
POWER_CTL="/usr/bin/powerprofilesctl"

# Get current profile using the system engine
current=$($SYS_PYTHON $POWER_CTL get)

# Define the three options
options="performance\nbalanced\npower-saver"

# Pipe the options into Wofi, showing the current profile in the prompt
choice=$(echo -e "$options" | wofi --show dmenu --prompt "Power Mode (Current: $current)" --lines 3)

# If the user made a valid selection, apply it and send a desktop notification
if [[ "$choice" == "performance" || "$choice" == "balanced" || "$choice" == "power-saver" ]]; then
    $SYS_PYTHON $POWER_CTL set "$choice"
    notify-send -u normal -a "System" "Power Profile Changed" "Engine set to: $choice mode"
fi
