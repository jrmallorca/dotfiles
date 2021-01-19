#!/bin/bash

file=$(mktemp)

xfce4-terminal --disable-server --command="nvim "$file"" # replace with your favorite terminal"

cat $file | head -c -1 | xdotool type --clearmodifiers --delay 0 --file -
rm "$file"
