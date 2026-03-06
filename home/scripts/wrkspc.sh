#!/usr/bin/env bash
CUR=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused==true) | .name')
CURWIND=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | "\(.output)"')
#workspaces on monitor
wom=5

#monitor to monitor
if [[ $CURWIND == "eDP-1" ]]; then
  if [[ "$1" == "mnext" ]]; then 
    swaymsg workspace $(swaymsg -t get_workspaces | jq -r '.[] | select(.visible and .output=="HDMI-A-1") | "\(.name)"')
#moving
  elif [[ "$1" == "movemnext" ]];then
    swaymsg move container to workspace $(swaymsg -t get_workspaces | jq -r '.[] | select(.visible and .output=="HDMI-A-1") | "\(.name)"')
    swaymsg workspace $(swaymsg -t get_workspaces | jq -r '.[] | select(.visible and .output=="HDMI-A-1") | "\(.name)"')
  fi
elif [[ $CURWIND == "HDMI-A-1" ]]; then
  if [[ "$1" == "mprev" ]]; then 
    swaymsg workspace $(swaymsg -t get_workspaces | jq -r '.[] | select(.visible and .output=="eDP-1") | "\(.name)"')
#moving
  elif [[ "$1" == "movemprev" ]]; then 
    swaymsg move container to workspace $(swaymsg -t get_workspaces | jq -r '.[] | select(.visible and .output=="eDP-1") | "\(.name)"')
    swaymsg workspace $(swaymsg -t get_workspaces | jq -r '.[] | select(.visible and .output=="eDP-1") | "\(.name)"')
  fi
fi

#in monitor, workspace to workspace
if [[ "$1" == "next" ]]; then 
  if (( (CUR) % wom != 0 )); then #keeps it inside the monitors workspaces
    swaymsg workspace $((CUR+1))
  fi
elif [[ "$1" == "prev" ]]; then
  if (( (CUR-1) % wom != 0 )); then #keeps it inside the monitors workspaces
    swaymsg workspace $((CUR-1))
  fi
fi

#moving
if [[ "$1" == "movenext" ]]; then
  if (( (CUR) % wom != 0 )); then #keeps it inside the monitors workspaces
    swaymsg move container to workspace $((CUR+1))
    swaymsg workspace $((CUR+1))
  fi
elif [[ "$1" == "moveprev" ]]; then
  if (( (CUR-1) % wom != 0 )); then #keeps it inside the monitors workspaces
    swaymsg move container to workspace $((CUR-1))
    swaymsg workspace $((CUR-1))
  fi
fi

#helper
if [[ "$1" == "w" ]]; then 
  echo $CURWIND 
fi
if [[ "$1" == "c" ]]; then 
  echo $CUR 
fi

