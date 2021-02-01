#!/bin/bash

SELECTED_TEXT=$(xclip -o)                  # Get highlighted text (Primary selection)
TEMP_FILE=$(mktemp editInVim.XXXXXXXX.txt) # Make temporary file as .txt for vim formatting

# TODO: Set it to $EDITOR to allow any editors
echo "$SELECTED_TEXT" >> $TEMP_FILE                           # Put text into temporary file
xfce4-terminal --disable-server --command="nvim "$TEMP_FILE"" # Start new terminal to edit file

# TODO: Conditionally remove file to retain info just in case
cat $TEMP_FILE | head -c -1 | xdotool type --clearmodifiers --delay 0 --file - # Get contents of file and type into the previously focused window
rm "$TEMP_FILE"                                                                # Delete file