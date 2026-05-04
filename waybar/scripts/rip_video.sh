#!/bin/bash
# Silent Video Ripper - JohnnyCyan Style
# Location: ~/.config/waybar/scripts/rip_video.sh

# 1. Launch Rofi to get the URL
URL=$(echo "" | rofi -dmenu \
    -p "Paste URL for VIDEO" \
    -theme lb \
    -font "Press Start 2P 10" \
    -icon-theme "Sovietec-OS" \
    -show-icons \
    -lines 0 \
    -theme-str 'window {width: 600px;} listview {lines: 0;}')

# 2. Validation
if [ -z "$URL" ]; then exit 0; fi

# 3. Notify
notify-send "Video Ripper" "Downloading Best Quality..." -i "download"

# 4. Execute in Background
(
    # -P ~/Videos : Save to Videos
    # default : Download best video+audio and merge
    if yt-dlp -P ~/Videos "$URL" > /dev/null 2>&1; then
        notify-send "Video Ripper" "Download Complete!" -i "video-x-generic"
    else
        notify-send "Video Ripper" "Download Failed." -i "dialog-error" -u critical
    fi
) &