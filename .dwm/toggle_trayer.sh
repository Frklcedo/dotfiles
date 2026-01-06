#!/bin/sh

TRAYER="trayer --edge bottom --iconspacing 2 --height 20 --align center --padding 20 --expand false --width 50"

if [ $(pgrep -x trayer) ]; then
    pkill -USR1 trayer
else
    $TRAYER &
fi
