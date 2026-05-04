#!/bin/bash

# JohnnyCyan System Monitor
# Converts CPU/RAM usage into 8-stage bars:  ▂▃▄▅▆▇█

get_bar() {
    local percent=$1
    local chars=" ▂▃▄▅▆▇█"
    # Map 0-100 to 0-7
    local index=$(( percent * 7 / 100 ))
    echo "${chars:$index:1}"
}

case "$1" in
    cpu)
        # Calculate CPU usage from /proc/stat
        read cpu a b c idle rest < /proc/stat
        prev_idle=$idle
        prev_total=$((a+b+c+idle))
        sleep 0.5
        read cpu a b c idle rest < /proc/stat
        total=$((a+b+c+idle))
        # Calculate diff
        diff_idle=$((idle-prev_idle))
        diff_total=$((total-prev_total))
        usage=$(( (1000 * (diff_total - diff_idle) / diff_total + 5) / 10 ))
        
        # Output JSON for Waybar
        bar=$(get_bar $usage)
        # Class for coloring (low, med, high)
        if [ $usage -gt 80 ]; then class="critical"; 
        elif [ $usage -gt 50 ]; then class="warning"; 
        else class="normal"; fi
        
        echo "{\"text\": \"$bar\", \"tooltip\": \"CPU: ${usage}%\", \"class\": \"$class\"}"
        ;;
        
    mem)
        # Calculate RAM usage
        usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
        
        bar=$(get_bar $usage)
        if [ $usage -gt 80 ]; then class="critical"; 
        elif [ $usage -gt 50 ]; then class="warning"; 
        else class="normal"; fi
        
        echo "{\"text\": \"$bar\", \"tooltip\": \"RAM: ${usage}%\", \"class\": \"$class\"}"
        ;;
esac
