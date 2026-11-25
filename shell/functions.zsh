# Switch kube context and show where you are. Usage: kctx [name]
kctx() { [ -n "$1" ] && kubectl config use-context "$1"; kubectl config current-context; }

# Pods in a namespace matching a pattern. Usage: kpods <namespace> [pattern]
kpods() { kubectl get pods -n "$1" | grep -E "${2:-.}"; }

# Fresh branch off main: newbranch <name>
newbranch() { git fetch origin main -q && git switch -c "$1" origin/main; }

# Jump to a repo under $REPOS_DIR (default ~/code). Usage: repo <name>
repo() { cd "${REPOS_DIR:-$HOME/code}/$1" 2>/dev/null || echo "no such repo: $1"; }

# Open the current branch's PR in the browser
pr() { gh pr view --web; }

# Fuzzy-switch local branch (needs fzf)
gsw() { local b; b=$(git branch --format='%(refname:short)' | fzf --height 40% --reverse) && git switch "$b"; }

# Pick a pod interactively and tail its logs. Usage: kpod <namespace>
kpod() { local p; p=$(kubectl get pods -n "$1" --no-headers -o custom-columns=:metadata.name | fzf --height 40% --reverse) && kubectl logs -f -n "$1" "$p"; }

# Prepend a directory to PATH if it exists and is not already there. Usage: setp <dir>
setp() { [ -d "$1" ] && case ":$PATH:" in *":$1:"*) ;; *) export PATH="$1:$PATH" ;; esac; }
