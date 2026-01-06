#!/bin/sh

TRAYER="trayer --edge top --align right --width 75 --height 20 --expand true --padding 12 --iconspacing 2 --transparent true --alpha 0 --tint 0x1e2127"

if [ $(pgrep -x trayer) ]; then
    pkill -USR1 trayer
else
    $TRAYER &
fi
