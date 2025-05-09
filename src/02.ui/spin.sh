#! /usr/bin/env bash
# spin.sh - Print a spinner with a message

# @depends on:
# - pen.sh
# - movements.sh
# - _symbols.sh

# Make sure the cursor is shown and the spinner stopped if the script exits abnormally
trap spop EXIT INT TERM

# Module state variables
_spinner_frame_duration=0.1
_spinner_pid=""

# Print a message with a spinner at the beginning
#
# Usage:
#   spin [options] text
# Options:
#   [same as pen.sh]
# Examples:
#   spin "Installing dependencies..."
#   sleep 2
#   spop
#   pen "Let's do something else now..."
#   --or, better--
#   spin "Installing dependencies..."
#   sleep 2
#   check "Dependancies installed."
spin() {
    local message=("$@")
    _spinner="${_spinner:-⣷⣯⣟⡿⢿⣻⣽⣾}"

    # If there is already a spinner running, stop it
    if spinning; then
        spop --keep-cursor-hidden
    fi

    # Run the spinner in the background
    (
        hide_cursor

        # Use a trap to catch USR1 signal for clean shutdown
        trap "show_cursor; exit 0" USR1

        # Print the first frame of the spinner
        pen -n cyan "${_spinner:0:1} "
        pen "${message[@]}"

        while true; do
            for ((i = 0; i < ${#_spinner}; i++)); do
                frame="${_spinner:$i:1}"
                up
                bol
                pen -n cyan "${frame} "
                pen "${message[@]}"
                sleep $_spinner_frame_duration
            done
        done
    ) &

    _spinner_pid=$!
}

# Stop the spinner
spop() {
    local keep_cursor_hidden=false
    [[ "$1" == "--keep-cursor-hidden" ]] && keep_cursor_hidden=true

    if spinning; then
        # Signal spinner to exit gracefully
        kill -USR1 "${_spinner_pid}" 2>/dev/null

        # Wait briefly for cleanup
        sleep $_spinner_frame_duration

        # Ensure it's really gone
        if ps -p "${_spinner_pid}" >/dev/null 2>&1; then
            kill "${_spinner_pid}" 2>/dev/null
            # Manually clean up display, unless asked not to do so
            if [[ "$keep_cursor_hidden" == false ]]; then
                show_cursor
            fi
        fi

        _spinner_pid=""
    fi
}

# Check if a spinner is running
spinning() {
    [[ -n "${_spinner_pid}" ]]
}

# Export the functions so they are available to subshells
export -f spin spop spinning
