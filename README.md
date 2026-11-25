# run-controls

Small dev-environment baseline. Homebrew plus a few zsh files; no Nix, no system-level changes.

- `Brewfile` — daily-driver CLI tools (kube, toolchain managers, pre-commit, search/navigation)
- `shell/` — aliases, history, tool init, helper functions, sourced from `~/.zshrc`
- `git/` — global gitignore and git settings (rebase on pull, rerere, delta pager)
- `scripts/doctor.sh [namespace]` — read-only check of tools, gh login and kubectl
- `scripts/macos.sh` — opt-in keyboard speed, no auto-correct, show file extensions (run by hand)
- `scripts/install.sh` — installs the Brewfile and wires `~/.zshrc` (idempotent)

Not here on purpose: secrets, tokens, AWS profiles and kube configs. 

Idea source: vasuadari/run_controls (reference only; its Agoda- and Nix-specific parts are dropped).
