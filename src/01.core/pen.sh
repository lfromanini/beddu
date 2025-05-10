#!/usr/bin/env bash
# pen.sh - Print pretty text

# @depends on:
# - _symbols.sh

# Print text with ANSI color codes and text formatting
#
# Usage:
#   pen [options] text
# Options:
#   -n: No newline after text
#   bold: Bold text
#   italic: Italic text
#   underline: Underline text
#   black|red|green|yellow|blue|purple|cyan|white|grey|gray: Color text
#   [0-9]: ANSI 256 color number
#   *: Any other text is printed as is
# Examples:
#   pen "Hello, world!"
#   pen -n "Hello, world!"
#   pen bold "Hello, world!"
#   pen italic blue "Hello, world!"
#   pen -n 219 underline "Hello, world!"
pen() {
    local new_line="\n"
    local text="${*: -1}"      # Get the last argument as the text
    local args=("${@:1:$#-1}") # Get all arguments except the last one
    local format_code=""
    local reset_code="\033[0m"

    for arg in "${args[@]}"; do
        arg=${arg,,} # Convert to lowercase
        case "$arg" in
        -n) new_line="" ;;
        bold) format_code+="\033[1m" ;;
        italic) format_code+="\033[3m" ;;
        underline) format_code+="\033[4m" ;;
        black) format_code+="\033[30m" ;;
        red) format_code+="\033[31m" ;;
        green) format_code+="\033[32m" ;;
        yellow) format_code+="\033[33m" ;;
        blue) format_code+="\033[34m" ;;
        purple) format_code+="\033[35m" ;;
        cyan) format_code+="\033[36m" ;;
        white) format_code+="\033[37m" ;;
        grey | gray) format_code+="\033[90m" ;;
        [0-9]*)
            # Check if this is a valid ANSI 256 color number
            if [[ "$arg" =~ ^[0-9]+$ ]] && [ "$arg" -ge 0 ] && [ "$arg" -le 255 ]; then
                format_code+="\033[38;5;${arg}m"
            fi
            ;;
        *) ;; # Ignore invalid arguments
        esac
    done

    printf "%b%s%b%b" "${format_code}" "${text}" "${reset_code}" "${new_line}"
}

# Export the pen function so it's available to subshells
export -f pen
