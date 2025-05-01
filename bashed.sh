#!/usr/bin/env bash
# ==============================================================================
# bashrc-installer - Custom .bashrc Configuration Manager
# 
# A script to install, manage, and theme custom bash configurations with:
# - Backup/Restore functionality
# - Theme selection system
# - Nerd Fonts integration
# ==============================================================================

# ------------------------------------------------------------------------------
# GLOBAL VARIABLES
# ------------------------------------------------------------------------------
readonly CURRENT_DIR=$(pwd)
readonly BACKUP_DIR="${CURRENT_DIR}/backup"
readonly SYSTEM_BASHRC="${HOME}/.bashrc"
readonly CUSTOM_BASHRC="${CURRENT_DIR}/.bashrc"
readonly BASH_THEME_FILE="${HOME}/.bash_theme"

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

# Display theme selection menu with Nerd Font icons and color descriptions
function select_theme() {
    cat <<EOF
Available Themes:

[1]  Arch Linux       (      ) - Cyan/White/Blue
[2]  Docker           (      ) - Blue/White/Cyan  
[3]  Ubuntu           (      ) - Green/White/Blue
[4]  Fedora           (  󱇯    ) - Red/White/Cyan
[5]  Debian           (      ) - Orange/White/Blue
[6]  Pink             (  󱢅    ) - Pastel Pink
[7]  MacOS            (  󰧨  󰷶  ) - Green/Gray/Cyan
[8]  Music            (󰌳    󰙽  ) - Purple/White/Blue
[9]  Rainbow          (      ) - Red/Green/Cyan
[10] Terminal         (      ) - Cyan/Purple/Blue
[11] Lightning        (  󱣝    ) - Green/Cyan/Blue
[12] Fire             (      ) - Red/Yellow/Cyan
[13] Space            (  󱎃    ) - Purple/Blue/Cyan
EOF

    read -rp "Select theme [1-13] (Default: 1): " theme_number

    # Validate input and set default if invalid
    if [[ "${theme_number}" =~ ^[1-9]$|^1[0-3]$ ]]; then
        echo "${theme_number}" > "${BASH_THEME_FILE}"
        echo "✓ Theme ${theme_number} saved"
    else
        echo "! Invalid input, using default theme (1)"
        echo "1" > "${BASH_THEME_FILE}"
    fi
}

# Install the custom bashrc with backup capability
function install_bashrc() {
    # Create backup directory with error handling
    if ! mkdir -p "${BACKUP_DIR}"; then
        echo "✗ Failed to create backup directory" >&2
        return 1
    fi

    # Backup existing .bashrc if present
    if [[ -f "${SYSTEM_BASHRC}" ]]; then
        if ! cp "${SYSTEM_BASHRC}" "${BACKUP_DIR}/.bashrc.backup"; then
            echo "✗ Backup failed" >&2
            return 1
        fi
        echo "✓ Original .bashrc backed up"
    else
        echo "ℹ No existing .bashrc found"
    fi

    # Install new configuration
    if [[ ! -f "${CUSTOM_BASHRC}" ]]; then
        echo "✗ Custom .bashrc not found" >&2
        return 1
    fi

    select_theme  # Prompt for theme selection

    if ! cp "${CUSTOM_BASHRC}" "${SYSTEM_BASHRC}"; then
        echo "✗ Installation failed" >&2
        return 1
    fi

    echo "✓ New .bashrc installed"
    source "${SYSTEM_BASHRC}"  # Apply changes
}

# Restore original bashrc from backup
function reset_bashrc() {
    if [[ ! -f "${BACKUP_DIR}/.bashrc.backup" ]]; then
        echo "✗ No backup found" >&2
        return 1
    fi

    if ! cp "${BACKUP_DIR}/.bashrc.backup" "${SYSTEM_BASHRC}"; then
        echo "✗ Restoration failed" >&2
        return 1
    fi

    echo "✓ Original .bashrc restored"
    source "${SYSTEM_BASHRC}"  # Apply changes
}

# Display usage information
function show_help() {
    cat <<EOF
Usage: ${0##*/} COMMAND

Commands:
  install   Install custom .bashrc with theme selection
  reset     Restore original .bashrc from backup  
  theme     Change theme without reinstalling
  help      Show this help message

Features:
  - 13 preconfigured themes with Nerd Fonts
  - Automatic backup/restore
  - Color-coded output
EOF
}

# ------------------------------------------------------------------------------
# MAIN EXECUTION
# ------------------------------------------------------------------------------

case "$1" in
    install)
        install_bashrc
        ;;
    reset)
        reset_bashrc
        ;;
    theme)
        select_theme
        ;;
    help|--help|-h|"")
        show_help
        ;;
    *)
        echo "Invalid command: $1" >&2
        show_help
        exit 1
        ;;
esac

exit 0