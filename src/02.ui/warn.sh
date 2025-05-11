#!/usr/bin/env bash
# shellcheck disable=SC1091
# warn.sh - Print a warning message

[[ $BEDDU_WARN_LOADED ]] && return
readonly BEDDU_WARN_LOADED=true

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/../00.utils/_symbols.sh"
source "$SCRIPT_DIR/../00.utils/movements.sh"
source "$SCRIPT_DIR/../01.core/pen.sh"
source "$SCRIPT_DIR/spin.sh"

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
        upclear
    fi

    pen -n yellow bold italic "${_warn:-!} "
    pen italic "$@"
}
