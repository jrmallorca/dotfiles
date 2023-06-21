#!/usr/bin/env bash

# Add flashcards to Anki via apy

cat_cmd=$([[ -n $(command -v bat) ]] && echo "bat" || echo "cat")
grep_cmd=$([[ -n $(command -v rg) ]] && echo "rg" || echo "grep")

get_tags_from_file() {
	tags_line=$("$cat_cmd" "$1" | "$grep_cmd" "tags: \[")
	tags=${tags_line#*: }
	result=$(echo "$tags" | tr -d "[]" | sed "s/,//g")

	echo "\"$result\""
}

get_deck_from_file() {
	echo $("$cat_cmd" "$1" | rg "deck: " | cut -d " " -f 2)
}

if [ -n "$1" ]; then
	if [ -f "$1" ]; then
		APY_PRESET="default"

		tags=$(get_tags_from_file $1)
		deck=$(get_deck_from_file $1)
		filename=$(basename "$1")

		IFS=$'\n' && for qa_pair in $("$cat_cmd" "$1" | rg " :: "); do
			question=${qa_pair% :: *}
			answer=${qa_pair#* :: }

			apy add-single \
				--preset "$APY_PRESET" \
				--deck "$deck" \
				--tags "$tags" \
				"$question" "$answer" "$filename"
		done
	else
		printf "ERROR: $pathToFile is not a file in this directory."
	fi
else
	printf "ERROR: File not provided."
fi
