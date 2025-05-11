#!/usr/bin/env bash
# @private

[[ $BEDDU_SYMBOLS_LOADED ]] && return
readonly BEDDU_SYMBOLS_LOADED=true

readonly _q='?'
readonly _a='❯'
readonly _o='◌'
readonly _O='●'
readonly _mark='✓'
readonly _warn='!'
readonly _cross='✗'
readonly _spinner='⣷⣯⣟⡿⢿⣻⣽⣾' # See for alternatives: https://antofthy.gitlab.io/info/ascii/Spinners.txt
readonly _spinner_frame_duration=0.1
