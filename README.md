# Dotfiles

My personal configuration for macOS. A reproducible development environment featuring **Fish**, **Ghostty**, **Zed**, and **Catppuccin** themes.

Managed via `stow`, `homebrew`, and `mise`.

## Prerequisites

**Install Homebrew** (this also installs Xcode Command Line Tools, which includes `git`):

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Installation

### 1. Clone this repo

```bash
git clone https://github.com/jordanrioux/dotfiles.git ~/dotfiles
```

### 2. Install apps and tools

```bash
brew bundle --file ~/dotfiles/Brewfile
```

### 3. Run the installer

This will link all config files, install Fish plugins, and set up development runtimes:

```bash
~/dotfiles/install.sh
```

## Post-Install (Manual Steps)

Some things require human intervention or cannot be scripted.

### System & Security

- **SSH & Git Signing:** Choose one:
  - [Setup with 1Password](docs/ssh-setup-1password.md) (recommended)
  - [Setup without 1Password](docs/ssh-setup.md)
- **Sudo via TouchID:**
  ```bash
  sudo nano /etc/pam.d/sudo_local
  ```
  Add this line:
  ```
  auth sufficient pam_tid.so
  ```
  *(Note: This file persists across macOS updates, unlike `/etc/pam.d/sudo`)*
- **Ghostty Terminfo** (fixes "unknown terminal" errors):
  ```bash
  infocmp -x | sudo tic -x -
  ```

### Application Permissions

- **Rectangle:** Grant "Accessibility" permission when prompted
- **Shottr:** Grant "Screen Recording" permission
- **OrbStack:** Open app, accept terms. If migrating, select "Import data from Docker Desktop"

### Development Tools

- **Go:** Install language server and linter - see [Go Setup](docs/go-setup.md)
- **Claude Code:** Login with `claude login`

### Fish Shell

Reload config after installation:

```bash
source ~/.config/fish/config.fish
```

Or use the `reload` abbreviation.