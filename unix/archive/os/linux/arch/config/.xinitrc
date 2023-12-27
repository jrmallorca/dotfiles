#!/bin/sh

setxkbmap -layout gb

xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --output "eDP-1-1" --auto --output "HDMI-0" --auto --left-of "eDP-1-1"
exec awesome
