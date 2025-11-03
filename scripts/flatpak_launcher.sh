#!/usr/bin/bash

flatpak_list=$(flatpak list)
selected_app_name=$(echo "$flatpak_list" | awk -F'\t' '{print $1}' | bemenu -i -H 20 --fn "FiraCode Nerd Font Mono Bold 9" --tb "#1e2127" --tf "#ffffff" --fb "#1e2127" --ff "#ffffff" --cb "#1e2127" --cf "#ffffff" --nb "#1e2127" --nf "#ffffff" --ab "#1e2127" --af "#ffffff" --hb "#ff90be" --hf "#282c34" --fbb "#fff000" --fbf "#ffeeff" -p "run >" --hp 6)

if [[ -n "$selected_app_name" ]]; then
    selected_app=$(echo "$flatpak_list" | awk -F '\t' -v app="$selected_app_name" '$1 == app {print $2}')
    flatpak run "$selected_app"
fi
