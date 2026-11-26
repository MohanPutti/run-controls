# run-controls

A small developer-tools baseline for a Mac: Homebrew packages and apps, a few zsh files, git settings, and helper scripts. No Nix and no system-level changes beyond an opt-in settings script.

## Quick start

```sh
git clone git@github-personal:MohanPutti/run-controls.git ~/personal/run-controls
~/personal/run-controls/scripts/install.sh   # tools, shell wiring, git include
~/personal/run-controls/scripts/doctor.sh    # verify
~/personal/run-controls/scripts/macos.sh     # optional keyboard and typing settings
```

Open a new terminal afterwards. `install.sh` is idempotent and backs up `~/.zshrc` and `~/.gitconfig` once (as `*.pre-run-controls`) before editing them.

## Layout

| Path | What it does |
|---|---|
| `Brewfile` | CLI tools |
| `Brewfile.apps` | GUI apps; `install.sh` skips ones already in `/Applications` |
| `shell/` | Aliases, history, tool init and helper functions, sourced from `~/.zshrc` |
| `tmux/tmux.conf` | Minimal tmux config, linked only if you have none |
| `git/config` | Git settings included from `~/.gitconfig` (no name or email) |
| `git/gitignore_global` | Global ignore file |
| `scripts/install.sh` | Installs the Brewfile and wires zsh and git |
| `scripts/doctor.sh [namespace]` | Read-only check of tools, `gh` login and kubectl |
| `scripts/macos.sh` | Opt-in keyboard speed, no auto-correct, show file extensions |

## What you get

**Tools:** `awscli`, `kubectl`, `mise`, `gh`, `ripgrep`, `fzf`, `zoxide`, `fd`, `bat`, `delta`, `atuin`, `direnv`, `tmux`, `k9s`, `starship`, `gitleaks`.
**Apps:** Clipy, Docker Desktop, iTerm2, Hack Nerd Font, Visual Studio Code.

**Aliases:** `g` git, `k` kubectl, `kctxs` list contexts, `k9` read-only k9s, `be`/`rs`/`rc`/`rt` for bundle exec, rails server, rails console and rspec, `dc` docker compose, `cat` is `bat`.

**Helpers:**

| Command | Does |
|---|---|
| `kctx [name]` | Switch kube context and show the current one |
| `kpods <ns> [pattern]` | List pods in a namespace, filtered |
| `kpod <ns>` | Pick a pod with fzf and tail its logs |
| `newbranch <name>` | Create a branch from a fresh `origin/main` |
| `gsw` | Fuzzy-switch a local branch |
| `repo <name>` | `cd` into `$REPOS_DIR/<name>` (default `~/code`) |
| `setp <dir>` | Prepend a directory to `PATH` if it exists and is not already there |
| `pr` | Open the current branch's PR in the browser |
| `vpn [up\|down\|status\|log]` | Connect or disconnect the Pritunl VPN (prompts for password/OTP); `ctrl-x v` connects. Set `VPN_PROFILE` to pick a profile |

**Git settings:** rebase on pull, auto-set upstream on push, prune on fetch, auto-stash on rebase, `rerere`, histogram diffs, `delta` pager.

## Secret scanning

A global pre-commit hook runs `gitleaks` on staged changes and blocks the commit if it finds a secret. It then runs the repo's own `.git/hooks` as usual. Bypass once with `SKIP_GITLEAKS=1 git commit ...`. Skipped if you already set a global `core.hooksPath`.

## Optional: app and Chrome-profile hotkeys (Hammerspoon)

Not installed by default. Run `scripts/install.sh --with-hammerspoon` (or answer `y` at the prompt).

- `⌥1` iTerm, `⌥2` Chrome, `⌥3` VS Code, `⌥4` Slack, `⌥5` Claude, `⌥6` Docker, `⌥7` WhatsApp, `⌥8` Pritunl: focus or launch; press again to hide. `⌥R` reloads the config.
- Windows: `⌃⌥` + arrows snap to halves, `⌃⌥↩` maximize, `⌃⌥C` center, `⌃⌥N` next screen.
- Chrome profiles: add them to `~/.config/run-controls/hammerspoon.lua` (created from `hammerspoon/local.example.lua`, never committed). Use `⌥9` and `⌥0`; the key focuses that profile's window, or opens it.
- One-time: open Hammerspoon and grant Accessibility in System Settings > Privacy & Security.

## Notes

- Apps already in `/Applications` are skipped, not reinstalled. To hand one over to brew, quit it and run `brew install --cask <name> --adopt`.
- `macos.sh` changes system settings; log out and back in afterwards. Undo a line with `defaults delete NSGlobalDomain <key>`.
- No secrets, tokens, cloud profiles or kube configs live here.
- Optional extras, not installed by default: `kubectx`, `eza`, `just`, `git-absorb`, `watchexec`.
