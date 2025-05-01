#!/bin/bash
# ~/.bashrc - Interactive Bash configuration file

# ==============================================
# SECTION 1: BASIC CONFIGURATION
# ==============================================

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# ==============================================
# SECTION 2: ALIASES
# ==============================================

# Navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Listing
alias ls='ls -lh --color=auto'
alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# Utilities
alias grep='grep --color=auto'
alias cls='clear'
alias h='history'
alias j='jobs -l'

# ==============================================
# SECTION 3: THEME SYSTEM
# ==============================================

# Theme storage file
BASH_THEME_FILE="$HOME/.bash_theme"

# Load saved theme or fallback to default (theme 1)
if [[ -f "$BASH_THEME_FILE" ]]; then
    SELECTED_THEME=$(cat "$BASH_THEME_FILE")
else
    SELECTED_THEME=1
fi

# Theme definitions using Nerd Fonts icons
# Format: [ACCENT1, ACCENT2, ACCENT3, ACCENT4, USER_ICON, HOST_ICON, DIR_ICON, GIT_ICON]
declare -A THEMES=(
    [1]="\[\e[96m\] \[\e[97m\] \[\e[37m\] \[\e[94m\]    "
    # Arch Linux theme
    [2]="\[\e[94m\] \[\e[97m\] \[\e[37m\] \[\e[96m\]    "
    # Docker theme
    [3]="\[\e[92m\] \[\e[97m\] \[\e[37m\] \[\e[94m\]     "
    # Ubuntu theme
    [4]="\[\e[91m\] \[\e[97m\] \[\e[37m\] \[\e[96m\]  󱇯  "
    # Fedora theme
    [5]="\[\e[33m\] \[\e[97m\] \[\e[37m\] \[\e[94m\]    "
    # Debian theme
    [6]="\[\e[38;2;255;182;193m\] \[\e[38;2;255;218;233m\] \[\e[37m\] \[\e[38;2;255;140;160m\]  󱢅  "
    # Pink theme
    [7]="\[\e[92m\] \[\e[90m\] \[\e[37m\] \[\e[96m\]  󰧨 󰷶 "
    # MacOS theme
    [8]="\[\e[95m\] \[\e[97m\] \[\e[37m\] \[\e[94m\] 󰌳  󰙽 "
    # Music theme
    [9]="\[\e[91m\] \[\e[92m\] \[\e[37m\] \[\e[96m\]    "
    # Rainbow theme
    [10]="\[\e[96m\] \[\e[95m\] \[\e[37m\] \[\e[94m\]    "
    # Terminal theme
    [11]="\[\e[92m\] \[\e[96m\] \[\e[37m\] \[\e[94m\]  󱣝  "
    # Lightning theme
    [12]="\[\e[91m\] \[\e[93m\] \[\e[37m\] \[\e[96m\]    "
    # Fire theme
    [13]="\[\e[95m\] \[\e[94m\] \[\e[37m\] \[\e[96m\]  󱎃  "
    # Space theme
)

# Load selected theme
IFS=" " read -r ACCENT1 ACCENT2 ACCENT3 ACCENT4 USER_ICON HOST_ICON DIR_ICON GIT_ICON <<<"${THEMES[$SELECTED_THEME]}"

# ==============================================
# SECTION 4: GIT PROMPT FUNCTIONALITY
# ==============================================

git_prompt_info() {
    # Return if not in a git repository
    [[ ! -d .git && ! $(git rev-parse --is-inside-work-tree 2>/dev/null) == "true" ]] && return

    local branch=$(git symbolic-ref --short HEAD 2>/dev/null || git describe --tags --exact-match 2>/dev/null)
    local status=$(git status --porcelain=2 --branch 2>/dev/null)

    # Parse git status information
    local ahead=$(echo "$status" | grep -oP "(?<=ahead )\d+")
    local behind=$(echo "$status" | grep -oP "(?<=behind )\d+")
    local dirty=$(echo "$status" | grep -E '^[12MADRCU!? ]' | wc -l)
    local staged=$(echo "$status" | grep -E '^[1MARC]' | wc -l)
    local untracked=$(echo "$status" | grep -E '^\?' | wc -l)
    local stashed=$(git stash list 2>/dev/null | wc -l)

    # Build git prompt components
    local parts=""
    parts+="\[\e[38;5;45m\] $branch\[\e[0m\]"
    [[ $ahead -gt 0 ]] && parts+=" \[\e[38;5;70m\]$ahead\[\e[0m\]"
    [[ $behind -gt 0 ]] && parts+=" \[\e[38;5;124m\]$behind\[\e[0m\]"
    [[ $staged -gt 0 ]] && parts+=" \[\e[38;5;178m\]$staged\[\e[0m\]"
    [[ $dirty -gt 0 ]] && parts+=" \[\e[38;5;208m\]$dirty\[\e[0m\]"
    [[ $untracked -gt 0 ]] && parts+=" \[\e[38;5;210m\]$untracked\[\e[0m\]"
    [[ $stashed -gt 0 ]] && parts+=" \[\e[38;5;98m\]$stashed\[\e[0m\]"

    echo -e "$parts"
}

# ==============================================
# SECTION 5: COMMAND TIMING
# ==============================================

export TIMER_START

preexec() {
    TIMER_START=$(date +%s%N)
}

precmd() {
    # Display command execution time if it took longer than 500ms
    local TIMER_END=$(date +%s%N)
    local TIMER_DIFF=$(((TIMER_END - TIMER_START) / 1000000))
    if [[ $TIMER_DIFF -gt 500 ]]; then
        echo -e "\e[38;5;220m Command took $((TIMER_DIFF / 1000)).$((TIMER_DIFF % 1000))s\e[0m"
    fi
    update_prompt
}

# Hook into debug trap for command timing
trap 'preexec' DEBUG
PROMPT_COMMAND='EXIT_CODE=$?; precmd'

# ==============================================
# SECTION 6: PROMPT CUSTOMIZATION
# ==============================================

update_prompt() {
    # Python virtual environment indicator
    local venv=""
    [[ -n "$VIRTUAL_ENV" ]] && venv="\[\e[38;5;183m\] ($(basename "$VIRTUAL_ENV")) \[\e[0m\]"

    # User@host section with icons - FIXED spacing
    local user_host="${ACCENT1}${USER_ICON} \u ${ACCENT2}${HOST_ICON} \h\[\e[0m\]"

    # Current working directory with icon
    local cwd="${ACCENT3}in ${ACCENT4}${DIR_ICON} \w\[\e[0m\]"

    # Git status information
    local git_status=""
    if git rev-parse --is-inside-work-tree &>/dev/null; then
        git_status=" ${ACCENT1}${GIT_ICON} $(git_prompt_info)\[\e[0m\]"
    fi

    # Command exit code indicator
    local exit_code=""
    if [[ $EXIT_CODE -ne 0 ]]; then
        exit_code="\[\e[38;5;196m\]  $EXIT_CODE\[\e[0m\]"
    fi

    # Final prompt assembly
    PS1="${venv}${user_host} ${cwd}${git_status}${exit_code}\n "
}

# ==============================================
# SECTION 7: STARTUP COMMANDS
# ==============================================

# Display system information on login (if fastfetch is available)
if [[ -n "$PS1" && -z "$TMUX" && -z "$VSCODE_PID" && "$TERM_PROGRAM" != "vscode" ]]; then
    command -v fastfetch &>/dev/null && fastfetch
fi
