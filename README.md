# My Dotfiles

Configuration for my macOS development environment, managed via [GNU Stow](https://www.gnu.org/software/stow/) and Homebrew.

## 🛠 Prerequisites (Zero State)
Perform these steps manually on a fresh Mac installation before cloning this repo.

1.  **Install Command Line Tools** (Triggers the system popup):
    ```bash
    xcode-select --install
    ```

2.  **Install Homebrew**:
    ```bash
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```
    *Important: Follow the on-screen prompt to add brew to your PATH after installation.*

3.  **Install Git & Stow** (Required to start):
    ```bash
    brew install git stow
    ```

## 🚀 Installation

### 1. Clone the Repo
```bash
git clone https://github.com/jordanrioux/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

## Install System Packages (Brewfile)
```bash
brew bundle --file ~/dotfiles/Brewfile
```

## Link Configurations 
```bash
stow fish
stow ghostty
stow git
```

## Install runtimes
```bash
mise install
```

# 🛠 Manual Post-Install Steps

_These settings cannot be automated via script and must be done once._

### 1. Security & Git Signing 🔐
**Critical:** You must generate new SSH keys and authorize them with GitHub for commit signing to work.
👉 **[Read the SSH Setup Guide](docs/ssh-setup.md)**

### 2. Set Fish as Default Shell
```bash
echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish
```

_Action: Restart your terminal after this step._

## 3. Install Fisher (Plugin Manager)

Fisher is self-bootstrapping and manages Fish plugins.

```bash
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
```

## 4. Authenticate CLI tools

* __Github:__ Run `gh auth login`
* __VS Code:__ Open app and enable "Settings Sync".

# 📝 Maintenance / How-To

## Adding a new config file

To add a new application (e.g., `nvim`) to your dotfiles:

1. Create the folder structure: `mkdir -p ~/dotfiles/nvim/.config/nvim`
2. Move your config: `mv ~/.config/nvim/init.vim ~/dotfiles/nvim/.config/nvim/`
3. Link it: `cd ~/dotfiles && stow nvim`

## Updating your Brewfile

If you install a new app via brew manually, update the record:
```bash
cd ~/dotfiles
brew bundle dump --force --file=Brewfile
```