#!/usr/bin/env bash
# ==============================================================================
# bashrc-installer - Interactive Bashrc Config Manager
# ==============================================================================

# ------------------------------------------------------------------------------
# GLOBAL VARIABLES
# ------------------------------------------------------------------------------
readonly CURRENT_DIR="$(pwd)"
readonly BACKUP_DIR="${CURRENT_DIR}/backup"
readonly SYSTEM_BASHRC="${HOME}/.bashrc"
readonly CUSTOM_BASHRC="${CURRENT_DIR}/.bashrc"
readonly DEFAULT_BASHRC="${CURRENT_DIR}/default.bashrc"
readonly BASH_THEME_FILE="${HOME}/.bash_theme"
readonly MARKER="# CUSTOM_BASHRC"

# ------------------------------------------------------------------------------
# FUNCTIONS
# ------------------------------------------------------------------------------

# Display theme selection menu with Nerd Font icons
function select_theme() {
    cat <<EOF
Available Themes:
[1]  Arch Linux       (      )
[2]  Docker           (      )
[3]  Ubuntu           (      )
[4]  Fedora           (  󱇯    )
[5]  Debian           (      )
[6]  Pink             (  󱢅    )
[7]  MacOS            (  󰧨  󰷶  )
[8]  Music            (󰌳    󰙽  )
[9]  Rainbow          (      )
[10] Terminal         (      )
[11] Lightning        (  󱣝    )
[12] Fire             (      )
[13] Space            (  󱎃    )
EOF

    read -rp "Select theme [1-13] (Default: 1): " theme_number

    if [[ "${theme_number}" =~ ^[1-9]$|^1[0-3]$ ]]; then
        echo "${theme_number}" > "${BASH_THEME_FILE}"
        echo "✓ Theme ${theme_number} saved"
    else
        echo "! Invalid input, using default theme (1)"
        echo "1" > "${BASH_THEME_FILE}"
    fi
}

# Install the custom bashrc with backup and marker
function install_bashrc() {
    mkdir -p "${BACKUP_DIR}"

    # Backup existing
    if [[ -f "${SYSTEM_BASHRC}" ]]; then
        cp "${SYSTEM_BASHRC}" "${BACKUP_DIR}/.bashrc.backup"
        echo "✓ Existing .bashrc backed up"
    fi

    if [[ ! -f "${CUSTOM_BASHRC}" ]]; then
        echo "✗ Custom .bashrc not found at ${CUSTOM_BASHRC}" >&2
        return 1
    fi

    # Insert marker if missing
    if ! grep -q "${MARKER}" "${CUSTOM_BASHRC}"; then
        echo -e "\n${MARKER}" >> "${CUSTOM_BASHRC}"
    fi

    select_theme

    cp "${CUSTOM_BASHRC}" "${SYSTEM_BASHRC}"
    echo "✓ New custom .bashrc installed"

    # Apply immediately in current shell
    # shellcheck disable=SC1090
    source "${SYSTEM_BASHRC}"
    echo "✓ Theme applied to current session"
}

# Change theme only if custom config is installed
function change_theme() {
    if ! is_custom_installed; then
        echo "✗ Custom .bashrc is not installed. Install it first."
        return 1
    fi
    select_theme
    # Apply new theme immediately
    # shellcheck disable=SC1090
    source "${SYSTEM_BASHRC}"
    echo "✓ Theme reapplied with new selection"
}

# Restore default bashrc template
function restore_default() {
    mkdir -p "${BACKUP_DIR}"

    if [[ ! -f "${DEFAULT_BASHRC}" ]]; then
        echo "✗ Default .bashrc not found at ${DEFAULT_BASHRC}" >&2
        return 1
    fi

    if [[ -f "${SYSTEM_BASHRC}" ]]; then
        cp "${SYSTEM_BASHRC}" "${BACKUP_DIR}/.bashrc.before-default"
        echo "✓ Current .bashrc backed up"
    fi

    cp "${DEFAULT_BASHRC}" "${SYSTEM_BASHRC}"
    echo "✓ Default .bashrc restored"

    echo "1" > "${BASH_THEME_FILE}"
    echo "✓ Theme reset to default (1)"

    # Apply immediately
    # shellcheck disable=SC1090
    source "${SYSTEM_BASHRC}"
    echo "✓ Default theme applied to current session"
}

# Backup current .bashrc manually
function backup_current() {
    mkdir -p "${BACKUP_DIR}"
    if [[ -f "${SYSTEM_BASHRC}" ]]; then
        cp "${SYSTEM_BASHRC}" "${BACKUP_DIR}/.bashrc.manual-backup"
        echo "✓ Current .bashrc backed up"
    else
        echo "ℹ No existing .bashrc found"
    fi
}

# Check if custom bashrc is installed
function is_custom_installed() {
    [[ -f "${SYSTEM_BASHRC}" ]] && grep -q "${MARKER}" "${SYSTEM_BASHRC}"
}

# ------------------------------------------------------------------------------
# MAIN LOOP
# ------------------------------------------------------------------------------
while true; do
    echo -e "\n\e[1;34m==== Bashrc Manager ====\e[0m"
    echo "1) Install custom bashrc"
    if is_custom_installed; then
        echo "2) Change theme"
    else
        echo -e "2) \e[2mChange theme (unavailable)\e[0m"
    fi
    echo "3) Restore default bashrc"
    echo "4) Backup current bashrc"
    echo "5) Exit"

    read -rp "Select option [1-5]: " choice

    case "$choice" in
        1) install_bashrc ;;
        2) 
            if is_custom_installed; then
                change_theme
            else
                echo "✗ Option unavailable. Install custom bashrc first."
            fi
            ;;
        3) restore_default ;;
        4) backup_current ;;
        5) echo "Goodbye!"; exit 0 ;;
        *) echo "Invalid option." ;;
    esac
done
