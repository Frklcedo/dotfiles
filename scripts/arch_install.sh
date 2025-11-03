#!/usr/bin/bash

# arch base

## network
sudo pacman -S networkmanager network-manager-applet

sudo pacman -S pipewire lib32-pipewire
sudo pacman -S wireplumber
sudo pacman -S pipewire-pulse 

sudo pacman -S gnu-free-fonts unzip curl notify-send libnotify fzf ripgrep ttf-fira-sans ttf-firacode-nerd otf-font-awesome ttf-liberation htop lib32-systemd less

sudo pacman -S nvidia-open
sudo pacman -S nvidia-settings
sudo pacman -S lib32-nvidia-utils

sudo pacman -S nwg-look qt6ct dunst nemo 
sudo pacman -S lazygit keychain alacritty librsvg openconnect libreoffice-fresh xdg-user-dirs zoxide bat openssh openfortivpn man-db exa
sudo systemctl enable sshd
sudo pacman -S networkmanager-openconnect

sudo pacman -S --needed base-devel
sudo pacman -S cmake
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si

# install zsh
sudo pacman -S zsh
chsh -s /usr/bin/zsh
curl -s https://ohmyposh.dev/install.sh | bash -s

# development tools
sudo pacman -S php nvm luarocks
sudo pacman -S composer
nvm install --lts
npm i -g @vtsls/language-server @vue/language-server

sudo pacman -S docker mariadb-lts nginx-mainline apache 

# miscs 

sudo pacman -S obs-studio thunderbird filezilla gimp
