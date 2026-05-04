#!/bin/bash

# JohnnyCyan System Monitor
# Outputs explicit text: "CPU: XX%" and "RAM: XX%"

case "$1" in
    cpu)
        # Calculate CPU usage
        read cpu a b c idle rest < /proc/stat
        prev_idle=$idle
        prev_total=$((a+b+c+idle))
        sleep 0.5
        read cpu a b c idle rest < /proc/stat
        total=$((a+b+c+idle))
        
        diff_idle=$((idle-prev_idle))
        diff_total=$((total-prev_total))
        
        if [ "$diff_total" -eq 0 ]; then usage=0; else
            usage=$(( (1000 * (diff_total - diff_idle) / diff_total + 5) / 10 ))
        fi
        
        # Color classes
        if [ $usage -gt 80 ]; then class="critical"; 
        elif [ $usage -gt 50 ]; then class="warning"; 
        else class="normal"; fi
        
        # CHANGED: Output the number and % sign
        echo "{\"text\": \"CPU: ${usage}%\", \"tooltip\": \"CPU: ${usage}%\", \"class\": \"$class\"}"
        ;;
        
    mem)
        # Calculate RAM usage
        usage=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
        
        if [ $usage -gt 80 ]; then class="critical"; 
        elif [ $usage -gt 50 ]; then class="warning"; 
        else class="normal"; fi
        
        # CHANGED: Output the number and % sign
        echo "{\"text\": \"RAM: ${usage}%\", \"tooltip\": \"RAM: ${usage}%\", \"class\": \"$class\"}"
        ;;
esac