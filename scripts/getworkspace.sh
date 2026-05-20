swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name'
