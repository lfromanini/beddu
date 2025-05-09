# Beddu

A lightweight bash framework for interactive scripts with pretty output.

## Overview

**Beddu** is a minimalist bash library that makes your terminal scripts more interactive and visually appealing. It provides easy-to-use functions for colorful text, spinners, progress indicators, and user interaction.

## Features

- **Text Formatting**: Bold, italic, underline and more
- **Color Support**: Basic colors and full ANSI 256 color support
- **User Interaction**: Ask for input, confirmations, and present menu choices
- **Visual Indicators**: Spinners, checkmarks, and error symbols
- **Line Manipulation**: Replace previous output for dynamic updates

## Installation

Clone the repository or download `beddu.sh` to your project:

```bash
# Clone the repository
git clone https://github.com/mjsarfatti/beddu.git

# Or download just the script
curl -O https://raw.githubusercontent.com/mjsarfatti/beddu/main/beddu.sh
```

## Usage

Source the `beddu.sh` file in your script:

```bash
#!/usr/bin/env bash
source "/path/to/beddu.sh"

# Now use beddu functions
pen bold blue "Hello, world!"
```

## Examples

More can be seen by looking at the [demo](./beddu.sh) file, but here is a quick overview:

### Text Formatting and Colors

```bash
# Basic formatting
pen bold "Bold text"
pen italic "Italic text"
pen underline "Underlined text"

# Colors
pen red "Red text"
pen green "Green text"
pen 39 "ANSI color code 39 (light blue)"

# Combined
pen bold red "Bold red text"

# Inline
echo "This is $(pen yellow "yellow"), and this is $(pen bold "bold")"
```

### Interactive Functions

```bash
# Ask for input
ask name "What's your name?"
pen "Hello, $name!"

# Yes/no confirmation (defaults to "yes")
if confirm "Continue?"; then
    pen green "Continuing..."
else
    pen red "Aborting."
fi

# Defaulting to "no"
if confirm --default-no "Are you sure?"; then
    pen green "Proceeding..."
else
    pen red "Cancelled."
fi

# Menu selection
choose color "Select a color:" "Red" "Green" "Blue"
pen "You selected: $color"
```

### Progress Indicators

```bash
# Show a progress spinner
spin "Working on it..."
sleep 2
check "Done!"

# Replace lines dynamically
pen "This will be replaced..."
sleep 1
repen "Processing started..."
sleep 1
repen spin "Almost done..." # Let's add a spinner for good measure
sleep 1
check "Task completed!" # We can directly `check` or `error` after a `spin` call - the message will always replace the spin line
```

## Demo

To see it in action paste the following command in your terminal:

```bash
curl -s https://raw.githubusercontent.com/mjsarfatti/beddu/main/demo.sh | bash
```

## Function Reference

### Text Formatting

- `pen [OPTIONS] TEXT` - Output formatted text
  - `-n` - No newline after output (must be the first option if used)
  - `bold`, `italic`, `underline` - Text styles
  - `red`, `green`, `blue`, etc. - Color names
  - `0-255` - ANSI color codes

### User Interaction

- `ask [retval] PROMPT` - Get text input from user, saves the answer in `$retval`
- `confirm [OPTIONS] PROMPT` - Get yes/no input
  - `--default-yes` - Set default answer to "yes" (default behavior)
  - `--default-no` - Set default answer to "no"
- `choose [retval] PROMPT [OPTIONS...]` - Display a selection menu, saves the answer in `$retval`

### Progress Indicators

- `spin MESSAGE` - Show animated spinner
- `check MESSAGE` - Show success indicator (if called right after a spinner, replaces that line)
- `error MESSAGE` - Show error indicator (if called right after a spinner, replaces that line)
- `repen [OPTIONS] MESSAGE` - Like `pen`, but replace the previous line
  - `-n` - No newline after output (must be the first option if used)
  - `spin`, `check`, `error` - If passed, use this function to print the message
  - `bold`, `italic`, `underline` - Text styles
  - `red`, `green`, `blue`, etc. - Color names
  - `0-255` - ANSI color codes

## FAQ

### Q: It doesn't work on my computer?

A: **Beddu** requires bash v4+. If your bash version checks out, please file an issue!

### Q: Can you add feature X?

A: Most likely, not. This is meant to be a _minimal_ toolkit to quickly jot down simple interactive scripts, nothing more. If you are looking for something more complete check out [Gum](https://github.com/charmbracelet/gum) (bash), [Inquire](https://github.com/mikaelmello/inquire) (Rust) or [Enquirer](https://github.com/enquirer/enquirer) (Node).

## License

[MIT](./LICENSE)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.
