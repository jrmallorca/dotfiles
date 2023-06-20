#!/bin/bash

# Add flashcards to Anki via apy
# TODO: Check if we should use bat/cat and rg/grep

if [ -f "$1" ]; then # Check if temp is a file
	filename=$(basename "$1")

	tags_line=$(bat "$1" | rg "tags: \[")            # Detect tags in file
	tags=${tags_line#*: }                            # Get array of tags
	tags=$(echo "$tags" | tr -d "[]" | sed "s/,//g") # Remove square brackets and commas

	deck=$(bat "$1" | rg "deck: " | cut -d " " -f 2) # Detect deck

	IFS=$'\n' && for qa_pair in $(bat "$1" | rg " :: "); do
		question=${qa_pair% :: *}
		answer=${qa_pair#* :: }
		apy add-single -s default -d "$deck" -t \""$tags"\" "$question" "$answer" "$filename" # Add to Anki
	done
else
	printf "ERROR: $pathToFile is not a file in this directory"
fi
