#!/usr/bin/env bash
# run.sh - Execute commands with output/error capture

# Execute a command with stdout and stderr capture capabilities
#
# Usage:
#   run --out output_var --err error_var command [args...]
#   run command [args...]
# Examples:
#   run --out output --err error echo "Hello, world!"
#   pen "You said: $output"
run() {
    local outvar_name errvar_name
    local -n outvar errvar # Declare namerefs (will be assigned below if needed)
    local cmd

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
        --out)
            outvar_name="$2"
            shift 2
            ;;
        --err)
            errvar_name="$2"
            shift 2
            ;;
        *)
            cmd=("$@")
            break
            ;;
        esac
    done

    # Set up namerefs if variable names are provided
    [[ -n "${outvar_name}" ]] && local -n outvar="${outvar_name}"
    [[ -n "${errvar_name}" ]] && local -n errvar="${errvar_name}"

    # Temporary files for capture
    local stdout_file stderr_file
    stdout_file=$(mktemp)
    stderr_file=$(mktemp)

    # Execute command with redirection
    "${cmd[@]}" >"${stdout_file}" 2>"${stderr_file}"
    local exit_code=$?

    # Assign outputs if requested
    # shellcheck disable=SC2034
    [[ -n "${outvar_name}" ]] && outvar="$(<"$stdout_file")"
    # shellcheck disable=SC2034
    [[ -n "${errvar_name}" ]] && errvar="$(<"$stderr_file")"

    rm -f "${stdout_file}" "${stderr_file}"
    return $exit_code
}

# Export the run function so it's available to subshells
export -f run
