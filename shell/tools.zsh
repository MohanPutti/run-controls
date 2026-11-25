# Initialise tools only if installed, so a partial setup never breaks the shell.
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"
command -v mise   >/dev/null && eval "$(mise activate zsh)"
command -v direnv >/dev/null && eval "$(direnv hook zsh)"
command -v atuin  >/dev/null && eval "$(atuin init zsh --disable-up-arrow)"
command -v fzf    >/dev/null && source <(fzf --zsh)
