#!/bin/bash
# 1. Kill old instances
pkill -f "cava -p"

# 2. Start Cava (pointing to your config)
# Ensure your config has 'raw_target = /tmp/cava.fifo'
cava -p ~/.config/cava/config > /dev/null 2>&1 &

# 3. Wait for FIFO to exist (Prevents immediate crash/restart loop)
while [ ! -p /tmp/cava.fifo ]; do sleep 0.1; done

# 4. The "Pure Bash" Loop (Zero Process Spawning)
while read -r line; do
    # Strip semicolons
    line="${line//;/}"
    
    # Swap numbers for bars using Bash internals (Fast & Cheap)
    line="${line//0/ }"
    line="${line//1/▂}"
    line="${line//2/▃}"
    line="${line//3/▄}"
    line="${line//4/▅}"
    line="${line//5/▆}"
    line="${line//6/▇}"
    line="${line//7/█}"
    
    echo "$line"
done < /tmp/cava.fifo