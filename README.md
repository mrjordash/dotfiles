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

* [SSH & Git Signing Setup with 1Password](docs/ssh-setup-1password.md)
* Or [SSH & Git Signing Setup](docs/ssh-setup.md)
* __Logins__: VS Code Sync, 1Password, Claude App.