#!/bin/sh

setxkbmap -layout gb

xrandr --output "eDP1" --auto --output "HDMI-0" --auto --left-of "eDP1" &
exec awesome
