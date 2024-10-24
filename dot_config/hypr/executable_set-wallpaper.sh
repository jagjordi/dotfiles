#!/bin/bash

hyprctl hyprpaper preload "${HOME}/.config/wallpaper.png"
for monitor in $(hyprctl monitors | grep Monitor | awk '{print $2}'); do
    hyprctl hyprpaper wallpaper "${monitor},${HOME}/.config/wallpaper.png"
done
