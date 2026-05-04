#!/bin/bash
# 1. Get the current workspace ID (where we want windows to go)
current_ws=$(hyprctl activeworkspace -j | jq '.id')

# 2. Find all clients in the 'special:minimized' workspace
windows=$(hyprctl clients -j | jq -r ".[] | select(.workspace.name == \"special:minimized\") | .address")

# 3. Loop through and move them back to CURRENT workspace
for addr in $windows; do
    hyprctl dispatch movetoworkspacesilent $current_ws,address:$addr
done