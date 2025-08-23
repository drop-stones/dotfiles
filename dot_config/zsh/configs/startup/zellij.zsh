# Do noghing if not WSL2
kernel_release=$(uname -r 2>/dev/null)
if [[ $kernel_release != *"WSL2"* ]]; then
  return
fi

list-add WSLENV -- "ZELLIJ/w" "ZELLIJ_SESSION_NAME/w" "ZELLIJ_PANE_ID/w"
