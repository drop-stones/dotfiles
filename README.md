# chezmoi-config

Windows dotfiles managed with [chezmoi](https://www.chezmoi.io).

## Features

- Configuration for daily tools: fish, PowerShell, git (+ delta, lazygit),
  alacritty, zellij, yazi, bat, fzf, ripgrep, direnv, tridactyl, and more
- Consistent [Tokyo Night](https://github.com/folke/tokyonight.nvim) theme
  across terminal tools
- Automated package installation via scoop, winget, rustup, cargo, and msys2
- WSL2 setup: `.wslconfig` (mirrored networking) and automatic
  [NixOS-WSL](https://github.com/nix-community/NixOS-WSL) installation
- Neovim configuration pulled from
  [nvim-config](https://github.com/drop-stones/nvim-config) as a chezmoi
  external

## Requirements

- Windows
- [scoop](https://scoop.sh)
- [chezmoi](https://www.chezmoi.io) (`scoop install chezmoi`)

## Installation

```console
chezmoi init --apply git@github.com:drop-stones/chezmoi-config.git
```

`chezmoi apply` deploys the dotfiles and runs the scripts in
`.chezmoiscripts/`:

- **install-packages**: adds scoop buckets (`extras`, `nerd-fonts`), installs
  all packages listed in `packages/*.lst` (scoop, winget, rustup, cargo,
  msys2), builds the bat cache, installs tridactyl-native, updates fish
  plugins via fisher, and installs the NixOS-WSL distro
- **set-env**: persists environment variables (XDG base directories, editor
  settings, etc.) to the Windows user environment
- **patch-msys2-shell**: patches `msys2_shell.cmd` so that msys2 shells work
  as expected

The scripts are `run_onchange`, so they re-run automatically when their
content changes. To force a re-run, use the `chezmoi-rerun` function
(available in both fish and PowerShell).

## Repository Structure

| Path               | Description                                                        |
| ------------------ | ------------------------------------------------------------------ |
| `dot_config/`      | `~/.config` — fish, git, lazygit, zellij, yazi, fzf, ripgrep, etc. |
| `AppData/`         | Windows `AppData` — alacritty, bat                                 |
| `Documents/`       | PowerShell profiles                                                |
| `dot_wslconfig`    | `~/.wslconfig` — WSL2 settings                                     |
| `packages/`        | Package lists for scoop, winget, rustup, cargo, and msys2          |
| `scripts/`         | PowerShell helper functions used by `.chezmoiscripts/`             |
| `.chezmoiscripts/` | Scripts executed on `chezmoi apply`                                |

## Machine-Specific Configuration

### `work` flag

`.chezmoi.toml.tmpl` defines a `work` data variable (default: `false`).
Setting it to `true` on work machines excludes personal configurations
(lazygit, tridactyl) from being applied.

### Local overrides

Machine-local git settings that should not be tracked by chezmoi can be
placed in `~/.config/git/config.local`, which is included from the git
config.
