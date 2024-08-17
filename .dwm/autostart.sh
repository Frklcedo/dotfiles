#!/bin/sh
slstatus &
# $HOME/.dwm/statusbar.sh &
compton --config $HOME/.config/compton/compton.conf &
dunst &
nm-applet &
nitrogen --restore &
# /usr/bin/lxpolkit &
# /usr/bin/emacs --daemon
# /usr/bin/dunst &
# setxkbmap br
# setxkbmap -model abnt2 -layout br
# playerctld daemon
# caffeine &

