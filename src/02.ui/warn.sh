#! /usr/bin/env bash
# warn.sh - Print a warning message

# @depends on:
# - pen.sh
# - movements.sh
# - _symbols.sh

# Print a "!" with a message, and stop and replace the
# spinner if it's running (relies on the spinner being
# the last thing printed)
#
# Usage:
#   warn [options] text
# Options:
#   [same as pen.sh]
# Examples:
#   warn "Failed, world!"
#   warn bold "Failed, world!"
#   --or--
#   spin "Installing dependencies..."
#   sleep 2
#   warn "Did you forget to feed the cat?"
warn() {
    # If there is a spinner running, stop it and clear the line
    if spinning; then
        spop
        up
        bol
        cl
    fi

    pen -n yellow bold italic "${_warn:-!} "
    pen italic "$@"
}

# Export the warn function so it can be used in other scripts
export -f warn
