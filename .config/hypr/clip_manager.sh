#!/bin/bash

# Define the "Clear Clipboard" option
CLEAR_OPTION="[ CLEAR CLIPBOARD ]"

# Get the list of clipboard entries and prepend the clear option
selection=$( (echo "$CLEAR_OPTION"; cliphist list) | wofi --dmenu --prompt "Clipboard History")

if [ "$selection" = "$CLEAR_OPTION" ]; then
    # Clear both text and images from cliphist
    cliphist wipe
    notify-send "Clipboard Cleared"
elif [ -n "$selection" ]; then
    # Decode and copy the selected item
    echo "$selection" | cliphist decode | wl-copy
fi
