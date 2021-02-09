# Gets selected text, if any, and pastes it into temporary file.
# Opens default terminal, opens temporary file in default editor.
# Once finished editing, exits terminal and writes (does not copy and paste)
# contents down.
#
# Note: Can only handle one paragraph at a time.

#!/bin/bash

SELECTED_TEXT=$(xclip -o)                  # Get highlighted text (Primary selection)
TEMP_FILE=$(mktemp editInVim.XXXXXXXX.txt) # Make temporary file as .txt for vim formatting

echo "$SELECTED_TEXT" >> $TEMP_FILE # Put text into temporary file
$TERMINAL -e $EDITOR ~/$TEMP_FILE   # Start new terminal to edit file

# TODO: Conditionally remove file to retain info just in case?
cat $TEMP_FILE | xdotool type --clearmodifiers --delay 0 --file - # Get contents of file and type into the previously focused window
rm $TEMP_FILE                                                     # Delete file
