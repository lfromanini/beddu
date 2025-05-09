#! /usr/bin/env bash
# repen.sh - Overwrite the previous line with new text

# @depends on:
# - pen.sh
# - movements.sh

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

# Export the repen function so it can be used in other scripts
export -f repen
