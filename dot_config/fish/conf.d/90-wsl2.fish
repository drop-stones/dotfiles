# Do nothing if not WSL2
string match -q wsl2 (os_name); or return

# wsl2
add_wslenv WSL_DISTRO_NAME/w

# LS_COLORS
add_wslenv LS_COLORS/w

# zellij
add_wslenv ZELLIJ/w ZELLIJ_SESSION_NAME/w ZELLIJ_PANE_ID/w
