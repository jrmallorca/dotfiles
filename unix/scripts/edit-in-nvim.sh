#!/bin/bash

# Gets selected text, if any, and pastes it into temporary file.
# Opens default terminal, opens temporary file in default editor.
# Once finished editing, exits terminal and copies the contents
# into the clipboard.

TERM="alacritty"
TERM_FLAGS="--title edit-in-nvim.sh --command"

# (Linux only) Get highlighted text (Primary selection)
if [ "$OSTYPE" == "Linux" ]; then
	SELECTED_TEXT=$(wl-paste --primary)
else
	SELECTED_TEXT=""
fi

TMP_DIR=$(mktemp -d)
TMP_FILE=$TMP_DIR/edit-in-nvim.txt # Make temporary file as .txt for vim formatting

touch "$TMP_FILE"                         # Create file in temporary directory
echo "$SELECTED_TEXT" >>"$TMP_FILE"       # Put text into temporary file
"$TERM" $TERM_FLAGS "$EDITOR" "$TMP_FILE" # Start new terminal to edit file

# Get contents of file and copy into clipboard
# TODO: Conditionally remove file to retain info just in case?
if [ "$OSTYPE" == "MacOS" ]; then
	pbcopy <"$TMP_FILE"
else
	wl-copy <"$TMP_FILE"
fi

rm -rf "$TMP_DIR" # Delete file and temporary directory
