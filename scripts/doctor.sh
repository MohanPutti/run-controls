#!/usr/bin/env bash
# Quick read-only environment check, no agent needed. Never prints tokens or ARNs.
# Usage: doctor.sh [kube-namespace]
ok()   { printf "  ok    %s\n" "$1"; }
bad()  { printf "  FAIL  %s\n" "$1"; }

for t in git gh aws kubectl mise rg; do
  command -v "$t" >/dev/null && ok "$t installed" || bad "$t missing (run scripts/install.sh)"
done

gh auth status >/dev/null 2>&1 && ok "gh logged in" || bad "gh not logged in (gh auth login)"

ctx=$(kubectl config current-context 2>/dev/null)
[ -n "$ctx" ] && ok "kube context set" || bad "no kube context (configure kubeconfig)"
if [ -n "$1" ] && [ -n "$ctx" ]; then
  kubectl get pods -n "$1" --request-timeout=10s >/dev/null 2>&1 \
    && ok "kubectl can list pods in $1" || bad "kubectl cannot list pods in $1 (AWS MFA session / VPN?)"
fi
