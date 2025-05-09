#! /usr/bin/env bash
# confirm.sh - Read a yes/no confirmation from the user

# @depends on:
# - pen.sh
# - _symbols.sh
# - movements.sh

# Ask a question and get a yes/no answer from the user
#
# Usage:
#   confirm text
# Options:
#   --default-yes: Answer 'yes' on ENTER (default)
#   --default-no: Answer 'no' on ENTER
# Example:
#   if confirm "Would you like to continue?"; then
#     pen "Great!"
#   else
#     pen "Ok, bye!"
#   fi
confirm() {
    local default="y"
    local hint="[Y/n]"
    local prompt
    local response

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --default-no)
            default="n"
            hint="[y/N]"
            shift
            ;;
        --default-yes)
            shift
            ;;
        *) break ;;
        esac
    done

    # Set prompt with default indicator
    prompt=$(
        pen -n blue "${_q:-?} "
        pen -n "$1"
        pen gray " $hint"
        pen -n blue "${_a:-❯} "
    )

    show_cursor

    # Get response
    while true; do
        read -r -p "$prompt" response
        response="${response:-$default}"
        case "$response" in
        [Yy] | [Yy][Ee][Ss])
            upclear
            pen -n blue "${_a:-❯} "
            pen "yes"
            return 0
            ;;
        [Nn] | [Nn][Oo])
            upclear
            pen -n blue "${_a:-❯} "
            pen "no"
            return 1
            ;;
        *)
            echo
            warn "Please answer yes or no."
            ;;
        esac
    done
}

# Export the confirm function so it's available to subshells
export -f confirm
