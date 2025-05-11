#!/usr/bin/env bash
# shellcheck disable=SC1091
# throw.sh - Print an throw message

[[ $BEDDU_THROW_LOADED ]] && return
readonly BEDDU_THROW_LOADED=true

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/../00.utils/_symbols.sh"
source "$SCRIPT_DIR/../00.utils/movements.sh"
source "$SCRIPT_DIR/../01.core/pen.sh"
source "$SCRIPT_DIR/spin.sh"

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
