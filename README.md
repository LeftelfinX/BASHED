# 🚀 BASHED: The Ultimate Bash Theme & Configuration Setup

![Terminal Preview](img/image.png)

This script automates setup of a customized `.bashrc` with Nerd Font theming, dynamic prompt, and Git integration.

## ✨ Features

- **13 Nerd Font Themes** - Professionally designed terminal themes
- **Dynamic Prompt** - Shows user, host, directory, and Git status
- **Git Integration** - Real-time branch tracking with status indicators
- **Performance Metrics** - Command execution timing (>500ms)
- **Safe Installation** - Automatic backup before changes

## 🛠 Installation

```bash
# Clone repository
git clone https://github.com/yourusername/bashed-terminal.git
cd bashed-terminal
```

### Install with theme selection

```bash
./bashed.sh install # Initial Installation
```

### Other commands:

```bash
./bashed.sh reset    # Restore original config
./bashed.sh theme    # Change theme
```

## 🎨 Available Themes

| ID  | Theme Name | Preview Icons | Colors      |
| --- | ---------- | ------------- | ----------- |
| 1   | Arch Linux | `      `     | Cyan/Blue   |
| 2   | Docker     | `      `     | Blue/Cyan   |
| 3   | Ubuntu     | `      `     | Green/Blue  |
| 4   | Fedora     | `  󱇯    `     | Red/Cyan    |
| 5   | Debian     | `      `     | Orange/Blue |
| 6   | Pink       | `  󱢅    `     | Pastel Pink |
| 7   | MacOS      | `  󰧨  󰷶  `     | Green/Gray  |
| 8   | Music      | `󰌳    󰙽  `     | Purple/Blue |
| 9   | Rainbow    | `      `     | Multi-color |
| 10  | Terminal   | `      `     | Cyan/Purple |
| 11  | Lightning  | `  󱣝    `     | Green/Cyan  |
| 12  | Fire       | `      `     | Red/Yellow  |
| 13  | Space      | `  󱎃     `     | Purple/Blue |

## 📷 Screenshots

| Theme Example                      | Git Integration             | Command Timing                    |
| ---------------------------------- | --------------------------- | --------------------------------- |
| ![Theme 1](screenshots/theme1.png) | ![Git](screenshots/git.png) | ![Timing](screenshots/timing.png) |

## ⚙️ Requirements

- **Bash** 4.0+
- **Nerd Fonts** (recommended: FiraCode, Hack)
- **Git** (for full functionality)

---

**Pro Tip**: For best experience, use with terminal emulators that support Nerd Fonts like:

- Windows Terminal
- iTerm2 (macOS)
- Kitty
- Alacritty

## 📜 License

MIT Licensed - Free for personal and commercial use

---