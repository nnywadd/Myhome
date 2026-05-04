#!/bin/bash
# Silent Sound Ripper - JohnnyCyan Style
# Location: ~/.config/waybar/scripts/rip_url.sh

# 1. Launch Rofi to get the URL
URL=$(echo "" | rofi -dmenu \
    -p "Paste URL for AUDIO (MP3)" \
    -theme lb \
    -font "Press Start 2P 10" \
    -icon-theme "Sovietec-OS" \
    -show-icons \
    -lines 0 \
    -theme-str 'window {width: 600px;} listview {lines: 0;}')

# 2. Validation
if [ -z "$URL" ]; then exit 0; fi

# 3. Notify
notify-send "Sound Ripper" "Downloading Audio..." -i "download"

# 4. Execute in Background
(
    if yt-dlp --extract-audio --audio-format mp3 -P ~/Music "$URL" > /dev/null 2>&1; then
        notify-send "Sound Ripper" "Download Complete!" -i "audio-x-generic"
    else
        notify-send "Sound Ripper" "Download Failed." -i "dialog-error" -u critical
    fi
) &