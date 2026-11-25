#!/usr/bin/env bash
# Idempotent. Installs the Brewfile, then wires one source line into ~/.zshrc.
# Shell snippets stay in this repo; nothing is copied, so `git pull` updates them.
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"

command -v brew >/dev/null || { echo "Install Homebrew first: https://brew.sh"; exit 1; }
brew bundle --file="$ROOT/Brewfile"

# Back up files we are about to touch (once)
for f in ~/.zshrc ~/.gitconfig; do
  [ -f "$f" ] && [ ! -f "$f.pre-run-controls" ] && cp "$f" "$f.pre-run-controls"
done

LINE="for f in \"$ROOT\"/shell/*.zsh; do source \"\$f\"; done  # run-controls"
grep -qF "# run-controls" ~/.zshrc 2>/dev/null || echo "$LINE" >> ~/.zshrc

# Global gitignore, only if you have not set one
[ -n "$(git config --global core.excludesfile)" ] || git config --global core.excludesfile "$ROOT/git/gitignore_global"

# Include our git settings without overwriting yours
git config --global --get-all include.path | grep -qF "$ROOT/git/config" || git config --global --add include.path "$ROOT/git/config"

echo "Done. Open a new shell."
