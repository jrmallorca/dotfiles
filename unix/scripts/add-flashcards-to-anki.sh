#!/bin/bash

# Add flashcards to Anki via apy

if [ -n "$1" ]; then  # Check if argument is empty
	if [ -f "$1" ]; then # Check if argument is a file
		cat_cmd = [[ -n $(command -v bat) ]] && echo "bat" || echo "cat"
		grep_cmd = [[ -n $(command -v rg) ]] && echo "rg" || echo "grep"

		filename=$(basename "$1")

		tags_line=$("$cat_cmd" "$1" | "$grep_cmd" "tags: \[") # Detect tags in file
		tags=${tags_line#*: }                                 # Get array of tags
		tags=$(echo "$tags" | tr -d "[]" | sed "s/,//g")      # Remove square brackets and commas

		deck=$("$cat_cmd" "$1" | rg "deck: " | cut -d " " -f 2) # Detect deck

		IFS=$'\n' && for qa_pair in $("$cat_cmd" "$1" | rg " :: "); do
			question=${qa_pair% :: *}
			answer=${qa_pair#* :: }
			apy add-single -s default -d "$deck" -t \""$tags"\" "$question" "$answer" "$filename" # Add to Anki
		done
	else
		printf "ERROR: $pathToFile is not a file in this directory."
	fi
else
	printf "ERROR: File not provided."
fi
