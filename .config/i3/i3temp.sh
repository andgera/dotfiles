#!/usr/bin/env bash

MON=$(find /sys/devices/platform/coretemp.0/hwmon/ -type d -name 'hwmon[0-9]' -print | awk  -F/ '/hwmon[0-9]/ {print $7}')
BACMON=$(grep -om1 'hwmon[0-9]' ~/.config/i3/i3status.conf)

if [ "$MON" != "$BACMON" ]; then
        sed -i "s/$BACMON/$MON/g" ~/.config/i3/i3status.conf && i3 reload || exit
else
        exit
fi
