#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Aliases for convenience
alias ls='ls -lh --color=auto'
alias ll='ls -alh'
alias grep='grep --color=auto'
alias cls='clear'

# Quick navigation shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Load saved theme if it exists
BASH_THEME_FILE="$HOME/.bash_theme"
if [[ -f "$BASH_THEME_FILE" ]]; then
    SELECTED_THEME=$(cat "$BASH_THEME_FILE")
else
    SELECTED_THEME=1 # Default theme
fi

# Theme Definitions
declare -A THEMES
THEMES[1]="\[\e[96m\] \[\e[97m\] \[\e[37m\] \[\e[94m\] 🌊 💻 📂 🌿"   # Cyan
THEMES[2]="\[\e[94m\] \[\e[97m\] \[\e[37m\] \[\e[96m\] 🐳 🖥️ 📁 🐙"   # Blue
THEMES[3]="\[\e[92m\] \[\e[97m\] \[\e[37m\] \[\e[94m\] 🌱 🖥️ 📂 🍃"   # Green
THEMES[4]="\[\e[91m\] \[\e[97m\] \[\e[37m\] \[\e[96m\] 🔥 💻 📁 🔥"   # Red
THEMES[5]="\[\e[33m\] \[\e[97m\] \[\e[37m\] \[\e[94m\] 🧡 🖥️ 📂 🟠"   # Orange
THEMES[6]="\[\e[38;2;255;182;193m\] \[\e[38;2;255;218;233m\] \[\e[37m\] \[\e[38;2;255;140;160m\] 🌸 💖 🩷 🎀" # Pink
THEMES[7]="\[\e[92m\] \[\e[90m\] \[\e[37m\] \[\e[96m\] 🍏 💚 📂 🥒"   # Lime Green
THEMES[8]="\[\e[95m\] \[\e[97m\] \[\e[37m\] \[\e[94m\] 💜 🎵 📁 🔮"   # Purple
THEMES[9]="\[\e[91m\] \[\e[92m\] \[\e[37m\] \[\e[96m\] 🌈 🎨 📂 ✨"   # Rainbow
THEMES[10]="\[\e[96m\] \[\e[95m\] \[\e[37m\] \[\e[94m\] 🤖 🛠️ 📁 💾"  # Cyberpunk
THEMES[11]="\[\e[92m\] \[\e[96m\] \[\e[37m\] \[\e[94m\] 🌟 ⚡ 📂 🔆"  # Neon
THEMES[12]="\[\e[91m\] \[\e[93m\] \[\e[37m\] \[\e[96m\] 🔥 🌋 📂 💥"  # Fire
THEMES[13]="\[\e[95m\] \[\e[94m\] \[\e[37m\] \[\e[96m\] 🚀 🛰️ 🌠 🌎"  # Galaxy

# Apply selected theme
IFS=" " read -r ACCENT1 ACCENT2 ACCENT3 ACCENT4 EMOJI_USER EMOJI_HOST EMOJI_DIR EMOJI_GIT <<< "${THEMES[$SELECTED_THEME]}"

# Improved Git prompt with extra info
if [[ -f "/usr/share/git/completion/git-prompt.sh" ]]; then
    GIT_PS1_SHOWDIRTYSTATE=1     # Show unstaged (*) and staged (+) changes
    GIT_PS1_SHOWUNTRACKEDFILES=1 # Show untracked files (%)
    GIT_PS1_SHOWSTASHSTATE=1     # Show stash state ($)
    GIT_PS1_SHOWUPSTREAM="auto"  # Show upstream status
    source /usr/share/git/completion/git-prompt.sh
fi

# Function to update prompt dynamically
update_prompt() {
    local venv=""
    if [[ -n "$VIRTUAL_ENV" ]]; then
        venv="(🐍 venv: $(basename $VIRTUAL_ENV)) "
    fi
    PS1="${venv}${ACCENT1}${EMOJI_USER} \u ${ACCENT3}in ${ACCENT2}${EMOJI_HOST} \h ${ACCENT4}${EMOJI_DIR} \w ${ACCENT1}${EMOJI_GIT}$(__git_ps1 "(%s)")\[\e[0m\]\n=> "
}

# Command execution timer (displays only if command takes >500ms)
export TIMER_START
preexec() { TIMER_START=$(date +%s%N); }
precmd() {
    local TIMER_END=$(date +%s%N)
    local TIMER_DIFF=$(((TIMER_END - TIMER_START) / 1000000))
    [[ $TIMER_DIFF -gt 500 ]] && echo "⏳ Command took $((TIMER_DIFF / 1000)).$((TIMER_DIFF % 1000))s"
}

# Ensure both prompt update and timer work
trap 'preexec' DEBUG
PROMPT_COMMAND='precmd; update_prompt'

# Run fastfetch only in the first interactive shell, excluding VS Code
if [[ -n "$PS1" && -z "$TMUX" && -z "$VSCODE_PID" ]]; then
    if [[ -n "$PS1" && -z "$TMUX" && -z "$VSCODE_PID" && "$TERM_PROGRAM" != "vscode" ]]; then
        command -v fastfetch &>/dev/null && fastfetch
    fi
fi
