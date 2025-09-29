#!/usr/bin/bash

sudo pacman -S php php-apcu php-fpm php-gd php-igbinary php-imagick php-pgsql php-redis php-sodium

PKGS=$(pacman -Qq | grep '^php-' | sed 's/^php-//')

if ! pacman -Q php-legacy &> /dev/null; then
    echo "Instalando PHP Legacy com módulos correspondentes..."
    sudo pacman -S php-legacy $(echo "$PKGS" | sed 's/^/php-legacy-/')
fi
