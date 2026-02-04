#!/bin/bash

# Run this script once on a fresh Mac to configure system preferences.
echo "   🔧 Applying macOS defaults..."

# Close System Settings to prevent overriding
osascript -e 'tell application "System Settings" to quit'

# Disable "Auto-Correct" (Annoying for code)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# --- Finder ---
# Show all filename extensions (file.txt vs file)
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show hidden files (dotfiles) by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show the path bar at the bottom of Finder windows
defaults write com.apple.finder ShowPathbar -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Use List view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# --- DOCK & UI ---
# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make the Dock icons smaller (36 pixels)
defaults write com.apple.dock tilesize -int 56

# Don't show recent applications in Dock
defaults write com.apple.dock show-recents -bool false

# Remove workspace auto-switching
defaults write com.apple.dock workspaces-auto-swoosh -bool NO

# --- KEYBOARD & INPUT ---
# Fast Key Repeat (Speed up navigation)
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Disable "Smart Quotes" and "Smart Dashes" (Prevents syntax errors)
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# Use F1, F2, etc. as standard function keys
# (Note: On some Apple Silicon Macs, you might still need to toggle this manually in Settings once)
defaults write NSGlobalDomain com.apple.keyboard.fnState -bool true

# --- Screenshots ---
# Save screenshots to the Desktop (or change to ~/Downloads)
defaults write com.apple.screencapture location -string "${HOME}/Downloads"

# Disable shadow in screenshots (cleaner for docs)
defaults write com.apple.screencapture disable-shadow -bool true

# --- Restart UI ---
echo "   Restarting Finder and Dock to apply changes..."
killall Finder
killall Dock

echo "   ✅ Done. Note: You may need to restart your Mac for keyboard changes to fully take effect."