#!/usr/bin/env bash

# ~/dotfiles/install.sh
# The "One-Click" Setup Script

set -euo pipefail

echo "🚀 Starting Dotfiles Installation..."

DOTFILES_DIR="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"

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

# Older versions of this repo could fold the complete ~/.claude directory, or
# its agents and skills children, into this checkout. Unfold only links known
# to point back here so the external Dev Agent Kit can own those entries.
migrate_legacy_claude_root() {
    local managed_link="$HOME/.claude"
    local expected_target="$DOTFILES_DIR/claude/.claude"

    if [ ! -L "$managed_link" ]; then
        return 0
    fi

    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is required to validate the legacy Claude symlink: $managed_link"
        return 1
    fi

    local resolved_target
    resolved_target="$(python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$managed_link")"
    if [ "$resolved_target" != "$expected_target" ]; then
        echo "❌ Refusing to replace unexpected symlink: $managed_link -> $resolved_target"
        return 1
    fi
    if ! command -v git &> /dev/null || ! git -C "$DOTFILES_DIR" rev-parse --is-inside-work-tree &> /dev/null; then
        echo "❌ Git metadata is required to distinguish dotfiles from Claude runtime state."
        return 1
    fi

    unlink "$managed_link"
    mkdir -p "$managed_link"

    # Preserve runtime state that Claude may have written through the old
    # directory symlink while leaving package-owned files in the repository.
    local legacy_entry
    local entry_name
    local repo_relative
    for legacy_entry in "$expected_target"/* "$expected_target"/.[!.]* "$expected_target"/..?*; do
        if [ ! -e "$legacy_entry" ] && [ ! -L "$legacy_entry" ]; then
            continue
        fi
        entry_name="$(basename "$legacy_entry")"
        repo_relative="claude/.claude/$entry_name"
        if git -C "$DOTFILES_DIR" ls-files --error-unmatch -- "$repo_relative" &> /dev/null; then
            continue
        fi
        mv "$legacy_entry" "$managed_link/$entry_name"
    done

    echo "   → Migrated $managed_link to a physical runtime directory"
}

migrate_legacy_claude_directory() {
    local managed_name="$1"
    local managed_link="$HOME/.claude/$managed_name"
    local expected_target="$DOTFILES_DIR/claude/.claude/$managed_name"

    if [ ! -L "$managed_link" ]; then
        return 0
    fi

    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is required to validate the legacy Claude symlink: $managed_link"
        return 1
    fi

    local resolved_target
    resolved_target="$(python3 -c 'import os,sys; print(os.path.realpath(sys.argv[1]))' "$managed_link")"
    if [ "$resolved_target" != "$expected_target" ]; then
        echo "❌ Refusing to replace unexpected symlink: $managed_link -> $resolved_target"
        return 1
    fi

    unlink "$managed_link"
    mkdir -p "$managed_link"
    echo "   → Migrated $managed_link to a Dev Agent Kit-managed directory"
}

migrate_legacy_claude_root || exit 1
mkdir -p "$HOME/.claude"
migrate_legacy_claude_directory "agents" || exit 1
migrate_legacy_claude_directory "skills" || exit 1

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
    "claude"
    "continue"
    "mise"
)

# 4. Run Stow
echo "🔗 Linking configuration files..."
cd "$DOTFILES_DIR" || exit

for package in "${PACKAGES[@]}"; do
    echo "   → Stowing $package"
    if [ "$package" = "claude" ]; then
        stow --restow --no-folding --target="$HOME" "$package"
    else
        stow --restow --target="$HOME" "$package"
    fi
done

echo "   ✅ Done! All config files are linked."
echo

# Install the portable development agents and skills when the sibling repo exists.
AGENT_KIT_DIR="${AGENT_KIT_DIR:-$HOME/dev-agent-kit}"
if [ -f "$AGENT_KIT_DIR/scripts/install.py" ]; then
    expected_agent_kit_remote="git@github.com:mrjordash/dev-agent-kit.git"
    alternate_agent_kit_remote="https://github.com/mrjordash/dev-agent-kit.git"
    actual_agent_kit_remote="$(git -C "$AGENT_KIT_DIR" remote get-url origin 2>/dev/null || true)"

    if [ "$actual_agent_kit_remote" != "$expected_agent_kit_remote" ] && [ "$actual_agent_kit_remote" != "$alternate_agent_kit_remote" ]; then
        echo "❌ Refusing to execute an unverified Dev Agent Kit at $AGENT_KIT_DIR"
        echo "   Expected origin: $expected_agent_kit_remote"
        exit 1
    fi
    if ! command -v python3 &> /dev/null; then
        echo "❌ Python 3 is required to install the development agents."
        exit 1
    fi

    echo "🧭 Installing portable development agents..."
    if python3 "$AGENT_KIT_DIR/scripts/install.py" --platform all; then
        echo "   ✅ Development agents installed"
    else
        agent_install_status=$?
        if [ "$agent_install_status" -eq 2 ]; then
            echo "❌ Existing agent files were preserved. Review the conflicts before using --replace."
        else
            echo "❌ Agent installation failed. Run the installer directly for details."
        fi
        exit "$agent_install_status"
    fi
else
    echo "⚠️ Dev Agent Kit not found at $AGENT_KIT_DIR. Skipping agent installation."
    echo "   Clone it with: gh repo clone mrjordash/dev-agent-kit \"$AGENT_KIT_DIR\""
fi
echo

# Configure Claude Code MCP servers
echo "🤖 Configuring Claude Code MCP servers..."
if command -v claude &> /dev/null; then
    if claude mcp get playwright &> /dev/null; then
        echo "   → Playwright MCP already configured"
    else
        claude mcp add playwright --scope user -- npx -y @playwright/mcp
    fi
    echo "   ✅ MCP servers configured"
else
    echo "   ⚠️ Claude CLI not found. Skipping MCP server configuration."
fi
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
if read -r -p "🍎 Do you want to apply macOS system defaults now? (y/n) " -n 1 REPLY; then
    echo
else
    echo
    REPLY="n"
fi
if [[ $REPLY =~ ^[Yy]$ ]]; then
    ./macos/set-defaults.sh
fi
echo

echo "🎉 Setup complete!"
echo "   Restart your terminal to see changes."
