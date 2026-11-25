#!/usr/bin/env bash
# Opt-in macOS settings. Not called by install.sh. Log out and back in to apply keyboard changes.
# Undo any line with: defaults delete <domain> <key>
set -euo pipefail

# Keyboard: fastest repeat (1 = 15 ms), short delay (10 = 150 ms; System Settings minimum is 15), hold-to-repeat
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

# Typing: no auto-correct, smart quotes or dashes (they corrupt code and commands)
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Finder: show all file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
killall Finder >/dev/null 2>&1 || true

echo "Done. Log out and back in for keyboard changes."
