# Gets selected text, if any, and pastes it into temporary file.
# Opens default terminal, opens temporary file in default editor.
# Once finished editing, exits terminal and copies the contents
# into the clipboard.

#!/bin/bash

TERMINAL=alacritty
SELECTED_TEXT=$(xclip -out)                # Get highlighted text (Primary selection)
TEMP_FILE=$(mktemp editInVim.XXXXXXXX.txt) # Make temporary file as .txt for vim formatting

echo "$SELECTED_TEXT" >> $TEMP_FILE # Put text into temporary file
$TERMINAL -e $EDITOR ~/$TEMP_FILE   # Start new terminal to edit file

# TODO: Conditionally remove file to retain info just in case?
# cat $TEMP_FILE | xdotool type --clearmodifiers --delay 0 --file - # Get contents of file and type into the previously focused window
cat $TEMP_FILE | xclip -selection clipboard # Get contents of file and copy into clipboard
rm $TEMP_FILE                               # Delete file
