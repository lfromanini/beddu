#!/usr/bin/env bash

# Import the beddu.sh library
# shellcheck disable=SC1091
source "$(dirname -- "$0")/../build/beddu.sh"

# Demo function to showcase the framework
demo() {
    _violet=99
    _pink=219

    line
    pen $_violet "╔═════════════════════════════════════════════╗"
    pen $_violet "║                                             ║"
    pen $_violet "║                                             ║"
    pen -n $_violet "║                "
    pen -n $_pink "Beddu.sh Demo"
    pen $_violet "                ║"
    pen $_violet "║                                             ║"
    pen $_violet "║                                             ║"
    pen $_violet "╚═════════════════════════════════════════════╝"
    line
    line

    line
    spin $_pink "Loading text formatting..."
    sleep 1
    spop
    upclear
    pen $_pink italic "-- Text formatting --"
    line
    pen bold "This text is bold"
    pen italic "This text is italic"
    pen underline "This text is underlined"
    line

    line
    spin $_pink "Loading basic colors..."
    sleep 1
    spop
    upclear
    pen $_pink italic "-- Basic colors --"
    line
    pen red "Red text"
    pen green "Green text"
    pen yellow "Yellow text"
    pen blue "Blue text"
    pen purple "Purple text"
    pen cyan "Cyan text"
    pen white "White text"
    pen grey "Grey text"
    pen -n black "Black text"
    pen italic "[Black text - might not be visible]"
    line

    line
    spin $_pink "Loading ANSI 256 colors..."
    sleep 1
    spop
    upclear
    pen $_pink italic "-- ANSI 256 colors (examples) --"
    line
    pen 39 "Light blue text (39)"
    pen 208 "Orange text (208)"
    pen 82 "Light green text (82)"
    line

    line
    spin $_pink "Loading combined formatting..."
    sleep 1
    spop
    upclear
    pen $_pink italic "-- Combined formatting --"
    line
    pen bold blue "This text is bold and blue"
    pen bold italic red "This text is bold, italic and red"
    pen underline green "This text is underlined and green"
    pen bold 39 "This text is bold and light blue (ANSI 256 color 39)"
    pen italic 208 "This text is italic and orange (ANSI 256 color 208)"
    pen -n red "This is red "
    pen -n green "and this is green, "
    pen "all on the same line!"
    pen "And this is $(pen yellow "yellow"), and this is $(pen purple "purple")"
    line

    line
    spin $_pink "Loading output utilities..."
    sleep 1
    spop
    upclear
    pen $_pink italic "-- Output utilities --"
    line
    check "Task completed successfully!"
    throw "Operation failed."
    line

    line
    spin $_pink "Starting interactive experience..."
    sleep 1
    spop
    upclear
    pen $_pink italic "-- Interactive functions --"
    line

    ask name "How can I call you?"
    pen "Hello, $(pen bold cyan "${name:?}")"
    line

    choose color "What is your favorite color?" "Red" "Green" "Blue"
    pen "Nice choice, $(pen bold "${color:?}" "${color:?}")"
    line

    if confirm "Would you like to continue with the demo?"; then
        pen "OK, let's $(pen bold green "continue")!"
    else
        pen "Too bad, I'll $(pen bold red "continue anyway")…"
    fi
    line

    line
    spin $_pink "Loading output manipulation..."
    sleep 1
    spop --keep-cursor-hidden
    repen $_pink italic "-- Output manipulation --"
    line
    pen "This line will be replaced in 1 second..."
    sleep 1
    spop --keep-cursor-hidden
    repen "Processing your request..."
    sleep 1
    spop --keep-cursor-hidden
    upclear
    spin "Still working on it..."
    sleep 2
    check "Task completed successfully!"
    spin "Performing an operation that will fail (ask me how I know)"
    sleep 2
    throw "Operation failed"
    line

    # This is a 12MB file
    local filename="commonswiki-20250501-pages-articles-multistream-index1.txt-p1p1500000.bz2"
    local baseurl="https://dumps.wikimedia.org/commonswiki/20250501"

    line
    spin $_pink "Loading \`run\` utility..."
    sleep 1
    spop --keep-cursor-hidden
    repen $_pink italic "-- Run command output control --"
    line
    spin "Downloading file..."
    # `curl` writes to stderr, so we need to capture that
    if run --err output curl -O "$baseurl/$filename"; then
        check "Download complete!"
        line
        pen "${output:-}"
    else
        throw "Download failed!"
    fi
    line
    if confirm "Would you like to remove the downloaded file?"; then
        rm -f "$filename"
        check "File removed!"
    fi
    line
    pen bold green "All done!"
    line
}

# If this script is executed directly, show the demo
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    demo
fi
