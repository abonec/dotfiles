#!/bin/bash

if [ $1 -eq 2 ]
then
    POS="1680 95"
else
    POS="0 0"
fi

/usr/bin/xdotool windowmove `/usr/bin/xdotool getwindowfocus` $POS

exit 0