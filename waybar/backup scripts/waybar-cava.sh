# 1. Define the bar characters

bar=" ▂▃▄▅▆▇█"

dict="s/;//g;"



# Create the dictionary to replace numbers with bars

i=0

while [ $i -lt ${#bar} ]

do

dict="${dict}s/$i/${bar:$i:1}/g;"

i=$((i=i+1))

done



# 2. Kill any old cava instances to prevent duplicates

pkill -f "cava -p"



# 3. Start Cava in the background pointing to your config

# Ensure your ~/.config/cava/config has 'method = pipewire'

cava -p ~/.config/cava/config > /dev/null 2>&1 &



# 4. Read the fifo pipe and output the bars

while read -r line; do

echo "$line" | sed "$dict"

done < /tmp/cava.fifo