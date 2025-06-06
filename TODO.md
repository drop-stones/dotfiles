# TODO List

## dotfiles

- [x] Speedup install scripts (e.g., skip if packages are installed)

## Terminal Emulator

- [ ] `wezterm` cannot set environment variables on WSL2 from wezterm config (<https://github.com/wez/wezterm/discussions/4395>)
- [ ] Zellij colorscheme for zellij
- [ ] Layout settings have no effect after detach in zellij
- [ ] Setup status-bar in zelli

## Command Line Utilities

- [x] `direnv` setup (<https://github.com/direnv/direnv>)
- [ ] `batman` does not highlight flags (<https://github.com/eth-p/bat-extras/blob/master/doc/batman.md>)
- [ ] Config file for `eza` (<https://github.com/eza-community/eza/issues/897>)
- [ ] `fzf-tab` does not preview on msys2 (<https://github.com/Aloxaf/fzf-tab/issues/444>)
- [x] `yazi` does not work correctly on WSL2 (<https://github.com/sxyazi/yazi>)

## Nvim

- [ ] Setup `snacks.nvim` (<https://github.com/folke/snacks.nvim>)
- [x] Setup `obsidian.nvim` correctly on all platforms (<https://github.com/epwalsh/obsidian.nvim>)
- [ ] Speed up `im-switch.nvim` in WSL2 (<https://github.com/drop-stones/im-switch.nvim>)
- [x] Do not insert a single space by `gsa` (<https://github.com/echasnovski/mini.surround>)

## Keybindings

- [x] Ctrl + v: nvim vs alacritty
  - zsh: Paste from clipboard
  - nvim:
    - Normal: transition to visual mode
    - Insert/Search: Paste from clipboard
- [x] Ctrl + h/j/k/l: nvim vs zellij
- [x] Ctrl + g: zellij vs navi
