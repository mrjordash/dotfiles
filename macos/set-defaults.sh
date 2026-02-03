#!/bin/bash

# ~/.dotfiles/docs/macos-setup.sh
# Run this script once on a fresh Mac to configure system preferences.

echo "   🔧 Applying macOS defaults..."

# --- Finder ---
# Show all filename extensions (file.txt vs file)
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files (dotfiles) by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show the path bar at the bottom of Finder windows
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# --- Dock ---
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make the Dock icons smaller (36 pixels)
defaults write com.apple.dock tilesize -int 56

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# --- Keyboard (Crucial for Coding) ---
# Key Repeat: Fast!
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Disable "Auto-Correct" (Annoying for code)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# --- Screenshots ---
# Save screenshots to the Desktop (or change to ~/Downloads)
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Disable shadow in screenshots (cleaner for docs)
defaults write com.apple.screencapture disable-shadow -bool true

# --- Restart UI ---
echo "   Restarting Finder and Dock to apply changes..."
killall Finder
killall Dock

echo "   ✅ Done. Note: You may need to restart your Mac for keyboard changes to fully take effect."