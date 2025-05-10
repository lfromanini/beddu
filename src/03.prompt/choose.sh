#!/usr/bin/env bash
# choose.sh - Choose from a menu of options

# @depends on:
# - pen.sh
# - _symbols.sh
# - cursor.sh

# Print an interactive menu of options and return the selected option
#
# Usage:
#   choose outvar text [choices...]
# Example:
#   choose color "What is your favorite color?" "Red" "Blue" "Green"
#   pen "You chose $color!"
choose() {
    local -n outvar="$1"
    local prompt
    local options=("${@:3}") # Get options from third argument onwards

    local current=0
    local count=${#options[@]}

    # Set prompt with default indicator
    prompt=$(
        pen -n blue "${_q:-?} "
        pen -n "${2}"
        pen gray "[↑↓]"
    )

    # Hide cursor for cleaner UI
    hide_cursor
    trap 'show_cursor; return' INT TERM

    # Display initial prompt
    pen "$prompt"

    # Main loop
    while true; do
        local index=0
        for item in "${options[@]}"; do
            if ((index == current)); then
                pen -n blue "${_O:-●} "
                pen "${item}"
            else
                pen gray "${_o:-◌} ${item}"
            fi
            ((index++))
        done

        # Read a single key press
        read -s -r -n1 key

        # Handle arrow/enter keys
        if [[ $key == $'\e' ]]; then
            read -s -r -n2 -t 0.0001 escape
            key+="$escape"
        fi

        case "$key" in
        $'\e[A' | 'k') # Up arrow or k
            ((current--))
            [[ $current -lt 0 ]] && current=$((count - 1))
            ;;
        $'\e[B' | 'j') # Down arrow or j
            ((current++))
            [[ $current -ge "$count" ]] && current=0
            ;;
        '') # Enter
            break
            ;;
        esac

        # Clear screen and repeat
        echo -en "\e[${count}A\e[J"
    done

    # Pass selected option back to caller
    # shellcheck disable=SC2034
    outvar="${options[$current]}"
}
