#!/bin/bash
set -eu

changelog="CHANGELOG.md"
delimiter=" | "

main() {
    most_recent_entry=$(tail -1 $changelog)

    # IFS is the delimeter
    # and we split the most recent entry, store the list into entry_chunks
    IFS=$delimiter read -ra entry_chunks <<< $most_recent_entry
    for i in "${!entry_chunks[@]}"; do
        value="${entry_chunks[$i]}"
        echo value: $value
        next_position="$(($value + 1))"

        # We only need the first value, which is the row counter
        if [[ $i -eq 0 ]]; then
            break
        fi
    done

    echo next position: ${next_position}

    # MM-DD-YYYY
    formatted_date=$(date +%m-%d-%Y)

    new_entry="| ${next_position}${delimiter}${formatted_date}"


    # TODO: parse $PR_DESCRIPTION from the environment

    echo ""
    echo ""
    echo ""
    echo new_entry: $new_entry
    echo PR Description: $PR_DESCRIPTION
    echo ""
    echo ""
    echo ""

    # echo new_entry >> changelog

    # TODO: commit + push
}

main
