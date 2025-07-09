# 🚀 BASHED: Interactive Bashrc Manager & Nerd Font Prompt System

**BASHED** is a simple, interactive tool for managing your `.bashrc` setup.
It helps you **install**, **theme**, **backup**, or **restore** your Bash configuration in seconds — with a beautiful Nerd Font prompt, Git integration, and command timing.

![Terminal Preview](img/image.png)

---

## ✨ Features

✅ **13 Nerd Font Themes** — Pick from 13 pre-configured prompt themes (icons + colors).
✅ **Safe Install** — Automatically backs up your current `.bashrc` before replacing.
✅ **Dynamic Prompt** — Shows user, host, working directory, Python venv, Git branch, and status.
✅ **Git Status** — Displays branch, ahead/behind, staged, dirty, untracked, stashed indicators.
✅ **Command Timing** — Shows timing if any command runs longer than 500ms.
✅ **One Command** — Easy to install, change themes, or restore defaults interactively.

---

Absolutely! Here’s your **Aliases** section rewritten in a **clearer, polished Markdown format** — perfect for your README:

---

## ⚡️ Built-In Aliases

**BASHED** comes with a set of convenient, ready-to-use **aliases** that make everyday terminal tasks faster and easier.

### 📂 Navigation Shortcuts

| Command | Description                 |
| ------- | --------------------------- |
| `..`    | Go up **one** directory     |
| `...`   | Go up **two** directories   |
| `....`  | Go up **three** directories |

Quickly move up your folder hierarchy without typing long `cd ../../..` paths.

### 📑 Improved File Listing

| Command | Description                                            |
| ------- | ------------------------------------------------------ |
| `ls`    | List files in **long, human-readable**, colored format |
| `ll`    | List **all files**, including hidden, in long format   |
| `la`    | List **all except . and ..**                           |
| `l`     | List files in **columns** for compact view             |

Better defaults for `ls` — more info, better colors, fewer typos.

### ⚙️ Handy Utilities

| Command | Description                               |
| ------- | ----------------------------------------- |
| `grep`  | Always highlights matches with `--color`  |
| `cls`   | Clear the terminal screen (like Windows)  |
| `h`     | Shortcut for `history`                    |
| `j`     | Show all **background jobs** with details |

These small tweaks save time and keep your shell workflow clean and efficient.

---

## ⚙️ Requirements

* **Bash** 4.x or newer
* **Nerd Fonts** (icons need a Nerd Font-enabled terminal)
* **Git** (optional but recommended)
* **fastfetch** (optional: displays system info at shell startup)

---

## 📥 Installation & Usage

1️⃣ **Clone this repo:**

```bash
git clone https://github.com/LeftelfinX/BASHED.git
cd BASHED
```

2️⃣ **Run the installer:**

```bash
./bashed.sh
```

You’ll see an interactive menu:

```bash
==== Bashrc Manager ====
1) Install custom bashrc
2) Change theme
3) Restore default bashrc
4) Backup current bashrc
5) Exit
```

✅ **Option 1:** Install the custom `.bashrc` with a theme selector.
✅ **Option 2:** Change the Nerd Font theme anytime (only if custom Bashrc is installed).
✅ **Option 3:** Restore your original default Bashrc (from `default.bashrc`).
✅ **Option 4:** Manually back up your current `.bashrc`.
✅ **Option 5:** Exit.

---

## 🎨 Theme Preview

Available Themes (with Nerd Font icons):

```bash
[1]  Arch Linux
[2]  Docker
[3]  Ubuntu
[4]  Fedora
[5]  Debian
[6]  Pink
[7]  MacOS
[8]  Music
[9]  Rainbow
[10] Terminal
[11] Lightning
[12] Fire
[13] Space
```

![list_image](/img/List.png)

Your selected theme is saved to `~/.bash_theme` — the prompt reads this every time.

---

## 📋 How It Works

✅ **Interactive Manager:**
Runs an infinite loop until you pick *Exit*. Safe, clear, and backup-aware.

✅ **Custom Bashrc:**
The custom `.bashrc`:

* Checks if the shell is interactive.
* Loads the selected theme (colors + icons).
* Defines aliases (`ls`, `grep`, `cd`, etc).
* Shows Git status in real time (` branch`, ` ahead`, ` behind` etc).
* Hooks into Bash `DEBUG` and `PROMPT_COMMAND` to time commands over 500ms.
* Displays a clean multi-line prompt with icons for user, host, working dir, and Git.

✅ **Default Bashrc:**
A bare minimum fallback:

```bash
case $- in
  *i*) ;;
  *) return ;;
esac
PS1='\u@\h:\w\$ '
```

When you *restore default*, this resets your shell to a safe minimal state.

✅ **Backup:**
All changes create timestamped backups under `./backup/`.

---

## 🖼️ Screenshots

Will be added soon!!

---

## 🧩 Tips

* Use a Nerd Font-enabled terminal (FiraCode, Hack Nerd Font, etc).
* Try **Kitty**, **Alacritty**, **Windows Terminal**, or **iTerm2** for best results.
* Install `fastfetch` for a nice system info splash on login.
* For My fastfetch config check project [FastFetched](https://github.com/LeftelfinX/FastFetched.git).

---

## 📜 License

MIT — Free to use, tweak, and share.
