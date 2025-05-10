#!/usr/bin/env bash
# throw.sh - Print an throw message

# @depends on:
# - pen.sh
# - movements.sh
# - _symbols.sh

# Print an throwmark with a message, and stop and replace the
# spinner if it's running (relies on the spinner being the last
# thing printed)
#
# Usage:
#   throw [options] text
# Options:
#   [same as pen.sh]
# Examples:
#   throw "Failed, world!"
#   throw bold "Failed, world!"
#   --or--
#   spin "Installing dependencies..."
#   sleep 2
#   throw "Did you forget to feed the cat?"
throw() {
    # If there is a spinner running, stop it and clear the line
    if spinning; then
        spop
        upclear
    fi

    pen -n red "${_cross:-✗} "
    pen "$@"
}

# Export the throw function so it can be used in other scripts
export -f throw
