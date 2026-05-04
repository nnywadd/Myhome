#!/bin/bash
# Emerge Ticker Tape - JohnnyCyan Edition
# Location: ~/.config/waybar/scripts/waybar-emerge.sh

# 1. Check if emerge is running.
if ! pgrep -x "emerge" > /dev/null; then
    echo "Gentoo: Idle"
    exit 0
fi

# 2. Check for genlop
if ! command -v genlop &> /dev/null; then
    echo "ERR: Install genlop"
    exit 0
fi

# 3. Get Data
raw_output=$(genlop -c)

# Parse Package Name (Line 1)
pkg_line=$(echo "$raw_output" | head -n 1 | sed 's/\* //')

# Parse Progress (Line 2)
progress_line=$(echo "$raw_output" | tail -n 1)
current=$(echo "$progress_line" | awk '{print $4}')
total=$(echo "$progress_line" | awk '{print $7}')

# 4. Safety Check
if [[ -z "$pkg_line" ]]; then
    echo "Genlop: Calculating..."
    exit 0
fi

# 5. Output Format (This triggers the scroll in Waybar)
echo "[ $current/$total ] $pkg_line"