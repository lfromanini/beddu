#!/usr/bin/env bash
# ask.sh - Get free text input from the user

# @depends on:
# - pen.sh
# - _symbols.sh
# - cursor.sh

# Ask a question and get a free text answer from the user
#
# Usage:
#   ask outvar text
# Example:
#   ask name "What is your name?"
#   echo "Hello, $name!"
ask() {
    local -n outvar="$1" # Declare nameref
    local prompt
    local answer

    # Set prompt with default indicator
    prompt=$(
        pen -n blue "${_q:-?} "
        pen "${2}"
        pen -n blue "${_a:-❯} "
    )

    show_cursor

    # Get response
    while true; do
        read -r -p "$prompt" answer
        case "$answer" in
        "")
            echo
            warn "Please type your answer."
            ;;
        *) break ;;
        esac
    done

    # shellcheck disable=SC2034
    outvar="$answer"
}

# Export the ask function so it's available to subshells
export -f ask
