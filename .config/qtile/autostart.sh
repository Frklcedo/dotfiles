#!/bin/sh
nitrogen --restore &
picom --config $HOME/.config/picom/picom.conf &
dunst &
/usr/bin/lxpolkit &
nm-applet &
# /usr/bin/emacs --daemon
# /usr/bin/dunst &
# setxkbmap br
setxkbmap -model abnt2 -layout br
playerctld daemon
caffeine
