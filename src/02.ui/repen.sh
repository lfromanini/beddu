#!/usr/bin/env bash
# shellcheck disable=SC1091
# repen.sh - Overwrite the previous line with new text

[[ $BEDDU_REPEN_LOADED ]] && return
readonly BEDDU_REPEN_LOADED=true

SCRIPT_DIR="$(dirname -- "${BASH_SOURCE[0]}")"
source "$SCRIPT_DIR/../00.utils/movements.sh"
source "$SCRIPT_DIR/../01.core/pen.sh"

# Move up one line, move to the beginning, clear the line, and print the text.
#
# Usage:
#   repen [options] text
# Options:
#   [same as pen.sh]
# Examples:
#   repen "Hello, world!"
#   repen bold "Hello, world!"
#   --or--
#   repen "Hello, world!"
repen() {
    upclear
    pen "$@"
}
