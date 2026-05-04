#!/bin/bash

# 1. Check if cmus is running
if ! pgrep -x "cmus" > /dev/null; then
    # Output exactly 25 spaces so the bar stays open/static
    echo "                         "
    exit 0
fi

# 2. Get Data
data=$(cmus-remote -Q)
artist=$(echo "$data" | grep "tag artist" | cut -d ' ' -f 3-)
title=$(echo "$data" | grep "tag title" | cut -d ' ' -f 3-)
file=$(echo "$data" | grep "^file" | cut -d ' ' -f 2-)
status=$(echo "$data" | grep "status" | cut -d ' ' -f 2)

# 3. Logic
if [ -z "$artist" ] && [ -z "$title" ]; then
    full_text=$(basename "$file")
else
    full_text="$artist - $title"
fi

# 4. Handle Pause
if [ "$status" != "playing" ]; then
    # "PAUSED" is 6 chars. 25 - 6 = 19. 
    # 9 spaces left, 10 spaces right.
    echo "         PAUSED          "
    exit 0
fi

# 5. Scroller (Width matches config: 25)
width=25
text="$full_text   $full_text   "
step=$(( $(date +%s) * 2 % ${#text} ))
output="${text:$step:$width}"

echo "$output"