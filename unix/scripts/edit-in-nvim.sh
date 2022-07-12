# Gets selected text, if any, and pastes it into temporary file.
# Opens default terminal, opens temporary file in default editor.
# Once finished editing, exits terminal and copies the contents
# into the clipboard.

#!/bin/bash

TERM="alacritty" # Set terminal as alacritty
TERM_FLAGS="--config-file $HOME/.config/alacritty/pop-up.yml -e"

# (Linux only) Get highlighted text (Primary selection)
if [ "$OSTYPE" == "Linux" ]; then
    echo "Start to copy selected text (Linux)"
    SELECTED_TEXT=$(xclip -out)
    echo $SELECTED_TEXT
else
    SELECTED_TEXT=""
fi

TMP_DIR=$(mktemp -d)
TMP_FILE=$TMP_DIR/edit-in-nvim.txt # Make temporary file as .txt for vim formatting

touch $TMP_FILE                    # Create file in temporary directory
echo "$SELECTED_TEXT" >> $TMP_FILE # Put text into temporary file
$TERM $TERM_FLAGS $EDITOR $TMP_FILE         # Start new terminal to edit file

# Get contents of file and copy into clipboard
# TODO: Conditionally remove file to retain info just in case?
if [ "$OSTYPE" == "MacOS" ]; then
    pbcopy < $TMP_FILE
else
    # cat $TMP_FILE | xdotool type --clearmodifiers --delay 0 --file - # Get contents of file and type into the previously focused window
    cat $TMP_FILE | xclip -selection clipboard
fi

rm -rf $TMP_DIR # Delete file and temporary directory
