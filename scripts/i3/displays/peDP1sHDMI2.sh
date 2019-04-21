#!/bin/sh

xrandr --output HDMI1 --auto --primary --pos 1920x0 --rotate normal --output eDP1 --auto --pos 0x0 --rotate normal
xrandr --output HDMI1 --set "Broadcast RGB" "Full"
