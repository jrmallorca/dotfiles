#!/bin/bash

# Add flashcards to Anki via apy
# TODO: Check if we should use bat/cat and rg/grep

if [ -f "$1" ]; then # Check if temp is a file
	filename=$(basename "$1")

	tags_line=$(bat "$1" | rg "tags: \[")            # Detect tags in file
	tags=${tags_line#*: }                            # Get array of tags
	tags=$(echo "$tags" | tr -d "[]" | sed "s/,//g") # Remove square brackets and commas
	if [[ -n "$tags" ]]; then                        # If tags aren't empty, add the flag
		tags="-t \"${tags}\""
	fi

	deck=$(bat "$1" | rg "deck: " | cut -d " " -f 2) # Detect deck
	if [[ -n "$deck" ]]; then                        # If deck is empty, then exit script
		deck="-d ${deck}"
	else
		printf "ERROR: No deck is provided"
		exit 1
	fi

	IFS=$'\n' && for qa_pair in $(bat "$1" | rg " :: "); do
		question=${qa_pair% :: *}
		answer=${qa_pair#* :: }
		# apy add-single -s default "$deck" "$tags" "$question" "$answer" "$filename" # Add to Anki
		printf "Deck: $deck"
	done
else
	printf "ERROR: $pathToFile is not a file in this directory"
fi
