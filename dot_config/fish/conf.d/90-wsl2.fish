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
wslwrap register bat
wslwrap register nvim
wslwrap register cargo
wslwrap register rustup
wslwrap register lazygit
wslwrap register dust
wslwrap register duf
wslwrap register dua
## windows
wslwrap register powershell --mode windows
wslwrap register pwsh --mode windows
wslwrap register cmd --mode windows
wslwrap register explorer --mode windows
wslwrap register wsl --mode windows
## symlink
wslwrap link win32yank.exe
wslwrap link cmd.exe
wslwrap link powershell.exe
wslwrap link pwsh.exe

# alias
alias msys2 "cmd.exe /c msys2.cmd -use-full-path -shell fish"
