# 🚀 Dotfiles

My personal configuration for macOS. A reproducible development environment featuring **Fish**, **Ghostty**, **Zed**, and **Catppuccin** themes.

Managed via `stow`, `homebrew`, and `mise`.

## 🛠 Prerequisites
1.  **Install Homebrew:**
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
2.  **Clone this repo:**
    ```bash
    git clone https://github.com/jordanrioux/dotfiles.git ~/dotfiles
    ```
3.  **Install your apps:**
    ```bash
    brew bundle --file ~/dotfiles/Brewfile
    ```

## ⚡️ Quick Start
I have automated the setup process. Run the installer to:
1.  Link all configuration files (Stow).
2.  Install Fish plugins (Fisher).
3.  Install development runtimes (Node.js LTS, etc.).
4.  (Optional) Apply macOS system defaults.

```bash
~/dotfiles/install.sh
```

# 🔐 Post-Install (Manual)

Some things cannot be automated. See `docs/` for details:

## ⚠️ Manual Post-Install Steps

While the `install.sh` handles 90% of the setup, these steps require human intervention or sudo permissions that cannot be scripted.

### 1. System & Security
- [SSH & Git Signing Setup with 1Password](docs/ssh-setup-1password.md)
    - Or [SSH & Git Signing Setup](docs/ssh-setup.md)
- **Sudo via TouchID:**
  - Edit the sudo config: `TERM=xterm-256color sudo nano /etc/pam.d/sudo`
  - Add `auth sufficient pam_tid.so` to the very top (Line 1).
  - *Note: This resets on major macOS updates.*
- **Ghostty Terminfo:**
  - Fix "unknown terminal" errors in root: `infocmp -x | sudo tic -x -`
- **Safari:**
  - Disable "Check spelling while typing" via `Edit > Spelling and Grammar` in the Menu Bar (cannot be disabled via Settings).

### 2. Application Permissions
- **Rectangle:** Grant "Accessibility" permission when prompted.
- **Shottr:** Grant "Screen Recording" permission (for pixel access).
- **OrbStack:**
  - Open App -> Accept Terms.
  - If migrating: Select "Import data from Docker Desktop".

### 3. AI & Secrets
- **Claude Code:**
  - Login: `claude login`
  - *Note:* The configuration is symlinked from `~/dotfiles/claude/.claude`, but the `.gitignore` inside that folder prevents session keys from being pushed.

### 4. Fish Shell
- **Reload Config:** `source ~/.config/fish/config.fish` (or `reload`)
- **Fisher Plugins:** Ensure plugins are installed: `fisher update`