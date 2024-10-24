#!/bin/sh

# check if way-displays is already running
if [ -n "$(pgrep way-displays)" ]; then
    pkill way-displays
fi
sleep 1 # give Hyprland a moment to set its defaults
nohup way-displays > "/tmp/way-displays.${XDG_VTNR}.${USER}.log" 2>&1 &
