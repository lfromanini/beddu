#!/usr/bin/env bash
# movements.sh - Cursor helper functions

[[ $BEDDU_MOVEMENTS_LOADED ]] && return
readonly BEDDU_MOVEMENTS_LOADED=true

# Move cursor up one line
up() {
    printf "\033[A"
}

# Move cursor down one line
down() {
    printf "\033[B"
}

# Move cursor to beginning of line
bol() {
    printf "\r"
}

# Move cursor to end of line
eol() {
    printf "\033[999C"
}

# Clear entire line
cl() {
    printf "\033[2K"
}

# Clear line above
upclear() {
    up; bol; cl
}

# Print a single newline
line() {
    printf "\n"
}

# Show cursor
show_cursor() {
    printf "\033[?25h"
}

# Hide cursor
hide_cursor() {
    printf "\033[?25l"
}
