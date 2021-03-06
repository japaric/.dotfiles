# X server
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && \
  exec startx

# keychain
command -v keychain >/dev/null 2>&1 && \
  eval $(keychain --eval id_rsa --agents gpg,ssh)
