#!/bin/bash
tint2 &
conky -q &
volumeicon &
nitrogen --restore &
xautolock -secure -time 7 -locker "/usr/bin/xlock -mode blank"  -detectsleep &
xflux -z 97210 > /dev/null 2>&1 &
pcmanfm -d &
(sleep 3 && valabattery) &
#compton -cCGb &
compton --config ~/.config/compton/compton.conf -b &
#(sleep 3 && /usr/bin/nm-applet --sm-disable) &
#xbacklight -set 100 &
#/usr/bin/synclient TouchpadOff=1 &
#fbxkb &
