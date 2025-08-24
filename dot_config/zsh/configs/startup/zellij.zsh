# Do nothing if not WSL2
is-wsl2 || return 0

list-add WSLENV -- "ZELLIJ/w" "ZELLIJ_SESSION_NAME/w" "ZELLIJ_PANE_ID/w"
