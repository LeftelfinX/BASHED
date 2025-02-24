#!/bin/bash

# Define paths
CURRENT_DIR=$(pwd)
BACKUP_DIR="$CURRENT_DIR/backup"
SYSTEM_BASHRC="$HOME/.bashrc"
CUSTOM_BASHRC="$CURRENT_DIR/.bashrc"
BASH_THEME_FILE="$HOME/.bash_theme"

# Function to prompt for theme selection
select_theme() {
    echo "Available Themes:"
    echo "[1]  Cyan 🌊"
    echo "[2]  Blue 🔵"
    echo "[3]  Green 🌿"
    echo "[4]  Red 🔥"
    echo "[5]  Orange 🍊"
    echo "[6]  Pink 🎀"
    echo "[7]  Lime Green 🍏"
    echo "[8]  Purple 💜"
    echo "[9]  Rainbow 🌈"
    echo "[10] Cyberpunk 🤖"
    echo "[11] Neon 🌟"
    echo "[12] Fire 🔥"
    echo "[13] Galaxy 🌌"

    read -p "Enter the number of the theme you want to apply: " theme_number

    if [[ $theme_number -ge 1 && $theme_number -le 13 ]]; then
        echo "$theme_number" > "$BASH_THEME_FILE"
        echo "✅ Theme $theme_number selected and saved."
    else
        echo "❌ Invalid selection. Defaulting to theme 1 (Cyan)."
        echo "1" > "$BASH_THEME_FILE"
    fi
}

install_bashrc() {
    # Create backup directory if not exists
    mkdir -p "$BACKUP_DIR"

    # Backup existing .bashrc
    if [[ -f "$SYSTEM_BASHRC" ]]; then
        cp "$SYSTEM_BASHRC" "$BACKUP_DIR/.bashrc.backup"
        echo "✅ Backup of .bashrc created in $BACKUP_DIR"
    else
        echo "⚠️ No existing .bashrc found. Skipping backup."
    fi

    # Prompt for theme selection before installing new .bashrc
    select_theme

    # Copy new .bashrc
    if [[ -f "$CUSTOM_BASHRC" ]]; then
        cp "$CUSTOM_BASHRC" "$SYSTEM_BASHRC"
        echo "✅ New .bashrc installed."
    else
        echo "❌ No .bashrc found in $CURRENT_DIR. Aborting."
        exit 1
    fi

    # Apply changes
    source "$SYSTEM_BASHRC"
}

reset_bashrc() {
    # Restore the backup .bashrc
    if [[ -f "$BACKUP_DIR/.bashrc.backup" ]]; then
        cp "$BACKUP_DIR/.bashrc.backup" "$SYSTEM_BASHRC"
        echo "✅ Original .bashrc restored."
        source "$SYSTEM_BASHRC"
    else
        echo "❌ No backup found. Cannot restore."
        exit 1
    fi
}

# Check command-line arguments
if [[ "$1" == "install" ]]; then
    install_bashrc
elif [[ "$1" == "reset" ]]; then
    reset_bashrc
elif [[ "$1" == "theme" ]]; then
    select_theme
else
    echo "Usage: $0 {install|reset|theme}"
    exit 1
fi
