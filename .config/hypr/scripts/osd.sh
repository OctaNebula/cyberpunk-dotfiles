#!/bin/bash

get_vol() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

get_light() {
    brightnessctl -d amdgpu_bl1 -m | awk -F, '{print substr($4, 1, length($4)-1)}'
}

case "$1" in
    vol_up)
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
        notify-send -a "OSD" -h int:value:"$(get_vol)" -h string:x-dunst-stack-tag:audio "󰝝 Volume: $(get_vol)%" -t 1500
        ;;
    vol_down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        notify-send -a "OSD" -h int:value:"$(get_vol)" -h string:x-dunst-stack-tag:audio "󰝞 Volume: $(get_vol)%" -t 1500
        ;;
    vol_mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        notify-send -a "OSD" -h string:x-dunst-stack-tag:audio "󰖁 Audio Toggled" -t 1500
        ;;
    mic_mute)
        wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
        notify-send -a "OSD" -h string:x-dunst-stack-tag:mic "󰍭 Mic Toggled" -t 1500
        ;;
    light_up)
        brightnessctl -d amdgpu_bl1 s 5%+
        notify-send -a "OSD" -h int:value:"$(get_light)" -h string:x-dunst-stack-tag:bright "󰃠 Brightness: $(get_light)%" -t 1500
        ;;
    light_down)
        brightnessctl -d amdgpu_bl1 s 5%-
        notify-send -a "OSD" -h int:value:"$(get_light)" -h string:x-dunst-stack-tag:bright "󰃞 Brightness: $(get_light)%" -t 1500
        ;;
esac
