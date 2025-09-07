# Do nothing if not WSL2
string match -q wsl2 (os_name); or return

# wsl2
add_wslenv WSL_DISTRO_NAME/w

# LS_COLORS
add_wslenv LS_COLORS/w

# zellij
add_wslenv ZELLIJ/w ZELLIJ_SESSION_NAME/w ZELLIJ_PANE_ID/w

# wslwrap.fish
## auto
wslwrap register git
wslwrap register rg
wslwrap register fd --path-separator=/
wslwrap register eza
wslwrap register nvim
wslwrap register cargo
wslwrap register lazygit
## windows
wslwrap register wsl --mode windows

# alias
alias msys2 "cmd.exe /c msys2.cmd -use-full-path -shell fish"
