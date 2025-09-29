#!/usr/bin/bash
sudo pacman -S egl-wayland
sudo pacman -S hyprland
sudo pacman -S polkit hyprpolkitagent
systemctl --user enable --now hyprpolkitagent.service
sudo pacman -S xdg-desktop-portal-hyprland qt5-wayland qt6-wayland hyprpaper waybar wofi wl-clipboard cliphist grim slurp wev

sudo pacman -S sddm
sudo systemctl enable sddm
