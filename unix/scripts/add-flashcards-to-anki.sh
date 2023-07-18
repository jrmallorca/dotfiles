#!/usr/bin/env bash

# Add flashcards to Anki via apy

cat_cmd=$([[ -n $(command -v bat) ]] && echo "bat" || echo "cat")
grep_cmd=$([[ -n $(command -v rg) ]] && echo "rg" || echo "grep")

get_tags_from_file() {
	tags_line=$("$cat_cmd" "$1" | "$grep_cmd" "tags: \[")
	tags=${tags_line#*: }
	result=$(echo "$tags" | tr -d "[]" | sed "s/,//g")

	if [[ "$result" =~ "to-complete" ]]; then
		printf "ERROR: Note is incomplete. Tag \"to-complete\" is still present."
		exit 1
	elif [[ "$result" =~ "to-tag" ]]; then
		printf "ERROR: Tagging note is incomplete. Tag \"to-tag\" is still present."
		exit 1
	else
		# Remove tags "to-add-links" and "to-generate-flashcards"
		# Remove leading and trailing whitespace
		for val in to-add-links to-generate-flashcards; do
			if [[ "$result" =~ $val ]]; then
				result=${result/$BASH_REMATCH/}
				result=$(echo -e "${result}" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//')
			fi
		done

		echo "\"$result\""
	fi
}

get_deck_from_file() {
	"$cat_cmd" "$1" | "$grep_cmd" "deck: " | cut -d " " -f 2
}

if [[ "$1" == "" ]]; then
	printf "ERROR: File not provided."
elif [[ ! -f "$1" ]]; then
	printf "ERROR: %s is not a file in this directory." "$1"
else
	APY_PRESET="default"

	tags=$(get_tags_from_file "$1")
	deck=$(get_deck_from_file "$1")
	filename=$(basename "$1")

	IFS=$'\n' && for qa_pair in $("$cat_cmd" "$1" | "$grep_cmd" " :: "); do
		question=${qa_pair% :: *}
		answer=${qa_pair#* :: }

		apy add-single \
			--parse-markdown \
			--preset "$APY_PRESET" \
			--deck "$deck" \
			--tags "$tags" \
			"$question" "$answer" "$filename"
	done

	apy sync
fi
