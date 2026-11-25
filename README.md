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
| `Brewfile` | CLI tools and apps |
| `shell/` | Aliases, history, tool init and helper functions, sourced from `~/.zshrc` |
| `tmux/tmux.conf` | Minimal tmux config, linked only if you have none |
| `git/config` | Git settings included from `~/.gitconfig` (no name or email) |
| `git/gitignore_global` | Global ignore file |
| `scripts/install.sh` | Installs the Brewfile and wires zsh and git |
| `scripts/doctor.sh [namespace]` | Read-only check of tools, `gh` login and kubectl |
| `scripts/macos.sh` | Opt-in keyboard speed, no auto-correct, show file extensions |

## What you get

**Tools:** `awscli`, `kubectl`, `mise`, `gh`, `ripgrep`, `fzf`, `zoxide`, `fd`, `bat`, `delta`, `atuin`, `direnv`, `tmux`.
**Apps:** Clipy, Docker Desktop, iTerm2, Visual Studio Code.

**Aliases:** `g` git, `k` kubectl, `kctxs` list contexts, `be`/`rs`/`rc`/`rt` for bundle exec, rails server, rails console and rspec, `dc` docker compose, `cat` is `bat`.

**Helpers:**

| Command | Does |
|---|---|
| `kctx [name]` | Switch kube context and show the current one |
| `kpods <ns> [pattern]` | List pods in a namespace, filtered |
| `kpod <ns>` | Pick a pod with fzf and tail its logs |
| `newbranch <name>` | Create a branch from a fresh `origin/main` |
| `gsw` | Fuzzy-switch a local branch |
| `repo <name>` | `cd` into `$REPOS_DIR/<name>` (default `~/code`) |
| `pr` | Open the current branch's PR in the browser |

**Git settings:** rebase on pull, auto-set upstream on push, prune on fetch, auto-stash on rebase, `rerere`, histogram diffs, `delta` pager.

## Notes

- Apps you already installed by hand may need `brew install --cask <name> --adopt` so brew takes them over.
- `macos.sh` changes system settings; log out and back in afterwards. Undo a line with `defaults delete NSGlobalDomain <key>`.
- No secrets, tokens, cloud profiles or kube configs live here.
- Optional extras, not installed by default: `k9s`, `kubectx`, `eza`, `just`, `git-absorb`, `watchexec`.
