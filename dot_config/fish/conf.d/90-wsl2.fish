# Do nothing if not WSL2
string match -q wsl2 (os_name); or return

# wsl2
add_wslenv WSL_DISTRO_NAME/w

# LS_COLORS
add_wslenv LS_COLORS/w

# zellij
add_wslenv ZELLIJ/w ZELLIJ_SESSION_NAME/w ZELLIJ_PANE_ID/w

# fish-wsl-wrapper
wsl_wrapper_register git
wsl_wrapper_register rg
wsl_wrapper_register fd --win_extra="--path-separator=/"
wsl_wrapper_register eza

# alias
alias msys2 "cmd.exe /c msys2.cmd -use-full-path -shell fish"
