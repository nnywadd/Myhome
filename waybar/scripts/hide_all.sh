#!/bin/bash
# 1. Get the current workspace ID
current_ws=$(hyprctl activeworkspace -j | jq '.id')

# 2. Find all clients (windows) on this workspace
# We grab their unique addresses
windows=$(hyprctl clients -j | jq -r ".[] | select(.workspace.id == $current_ws) | .address")

# 3. Loop through them and move them to special:minimized
for addr in $windows; do
    hyprctl dispatch movetoworkspacesilent special:minimized,address:$addr
done