#!/usr/bin/env bash

# ~/dotfiles/install.sh
# The "One-Click" Setup Script

echo "🚀 Starting Dotfiles Installation..."

# 1. Ensure Stow is installed
if ! command -v stow &> /dev/null; then
    echo "❌ Stow is not installed. Installing via Brew..."
    brew install stow
fi

# 2. Create necessary target directories
# (Stow will fail if the parent folder doesn't exist)
echo "📂 Ensuring config directories exist..."
mkdir -p ~/.config
mkdir -p ~/.ssh
mkdir -p "$HOME/Library/Application Support/Code/User" # For VS Code

# 3. List of folders to stow
# Add new folders here as you create them!
PACKAGES=(
    "fish"
    "git"
    "ghostty"
    "zed"
    "vscode"
    "starship"
    "bat"
    "fastfetch"
    "mise"
)

# 4. Run Stow
echo "🔗 Linking configuration files..."
cd "$HOME/dotfiles" || exit

for package in "${PACKAGES[@]}"; do
    echo "   → Stowing $package"
    stow -R "$package"
done

echo "   ✅ Done! All config files are linked."
echo

# Install Mise tools (Node, etc.)
if command -v mise &> /dev/null; then
    echo "📦 Installing development tools via Mise..."
    mise install --yes
else
    echo "⚠️ Mise not found. Skipping tool installation."
fi
echo

# 5. Fish Plugin Setup
echo "🐟 Setting up Fish shell..."
if ! grep -q "fisher" ~/.config/fish/functions/fisher.fish 2>/dev/null; then
    echo "   → Installing Fisher..."
    # Install Fisher purely via command line
    fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher update"
else
    echo "   → Fisher is already installed."
fi
echo

# Optional: Run macOS setup
read -p "🍎 Do you want to apply macOS system defaults now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macos/set-defaults.sh
fi
echo

echo "🎉 Setup complete!"
echo "   Restart your terminal to see changes."