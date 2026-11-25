# Pritunl VPN shortcuts. No credentials are stored; the password/OTP is prompted each time.
#   vpn up | down | status | log      (bare `vpn` = up)
# Set VPN_PROFILE=<profile id> to pick a profile; default is the first one listed.
_pritunl_bin=/Applications/Pritunl.app/Contents/Resources/pritunl-client

_vpn_profile() {
  [ -n "$VPN_PROFILE" ] && { echo "$VPN_PROFILE"; return; }
  "$_pritunl_bin" list 2>/dev/null | grep -oE '\| [0-9a-f]{16} ' | head -1 | tr -d '| '
}

vpn() {
  [ -x "$_pritunl_bin" ] || { echo "Pritunl client not found at $_pritunl_bin"; return 1; }
  local id; id=$(_vpn_profile)
  [ -n "$id" ] || { echo "No VPN profile found. Import one in the Pritunl app first."; return 1; }
  case "${1:-up}" in
    up)     "$_pritunl_bin" start "$id" --password-read ;;
    down)   "$_pritunl_bin" stop "$id" ;;
    status) "$_pritunl_bin" list ;;
    log)    "$_pritunl_bin" logs "$id" ;;
    *)      echo "usage: vpn [up|down|status|log]"; return 1 ;;
  esac
}

# Keyboard shortcut: ctrl-x then v connects (prompts for the password/OTP).
_vpn_widget() { zle -I; vpn up; zle reset-prompt; }
zle -N _vpn_widget
bindkey '^Xv' _vpn_widget
