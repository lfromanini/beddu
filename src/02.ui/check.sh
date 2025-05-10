#!/usr/bin/env bash
# check.sh - Print a success message

# @depends on:
# - pen.sh
# - movements.sh
# - _symbols.sh

# Print a checkmark with a message, and stop and replace the
# spinner if it's running (relies on the spinner being the last
# thing printed)
#
# Usage:
#   check [options] text
# Options:
#   [same as pen.sh]
# Examples:
#   check "Success, world!"
#   check bold "Success, world!"
#   --or--
#   spin "Installing dependencies..."
#   sleep 2
#   check "Dependancies installed."
check() {
    # If there is a spinner running, stop it and clear the line
    if spinning; then
        spop
        upclear
    fi

    pen -n green "${_mark:-✓} "
    pen "$@"
}

# Export the check function so it can be used in other scripts
export -f check
