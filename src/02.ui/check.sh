#!/usr/bin/env bash
# shellcheck disable=SC1091
# check.sh - Print a success message

[[ $BEDDU_CHECK_LOADED ]] && return
readonly BEDDU_CHECK_LOADED=true

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/../00.utils/_symbols.sh"
source "$SCRIPT_DIR/../00.utils/movements.sh"
source "$SCRIPT_DIR/../01.core/pen.sh"
source "$SCRIPT_DIR/spin.sh"

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
