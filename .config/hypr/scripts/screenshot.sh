#!/bin/bash

# 0. Safety net: Unfreeze the screen if the script violently crashes
trap 'kill $PICKER_PID 2>/dev/null' EXIT

# 1. Instantly freeze the display
hyprpicker -r -z &
PICKER_PID=$!

# Give the compositor a split second to render the freeze layer
sleep 0.1

# 2. Draw the selection box over the frozen screen
geometry=$(slurp -b '#05050880' -c '#00ffff' -w 2)

# 3. If a selection was made, capture it, unfreeze, and open
if [ -n "$geometry" ]; then
    # LET THE CYAN BORDER DISAPPEAR BEFORE SHOOTING
    sleep 0.2
    
    # Save the frozen frame to RAM
    temp_file="/tmp/capture.png"
    grim -g "$geometry" "$temp_file"
    
    # KILL THE FREEZE FRAME so we can actually see our desktop again
    kill $PICKER_PID 2>/dev/null
    
    # Open the image in Swappy
    swappy -f "$temp_file"
    
    # Clean up the RAM
    rm "$temp_file"
else
    # If you pressed Escape, just unfreeze the screen
    kill $PICKER_PID 2>/dev/null
fi
