# dotfiles

## Requirements

Package Manager:

- [`scoop`](https://scoop.sh) in Windows
- [`brew`](https://brew.sh) in Mac
- [`pacman`](https://wiki.archlinux.org/title/Pacman) in Arch Linux

dotfiles Tools: [`chezmoi`](https://www.chezmoi.io)

## Installation

At initialization, some configuration questions are asked.

```console
$ chezmoi init https://github.com/drop-stones/dotfiles.git
What is your git email address? <your email>
What is your git username? <your username>
Do you enable core.autocrlf of git? <true or false>
Do you use 1password for ssh? <true or false>
...
```

After initialization, you can install the dotfiles by the following command.

```console
chezmoi apply
```

## Setup

### WSL2

[ArchWSL](https://github.com/yuk7/ArchWSL) is installed by `scoop` at installation.
Setup instructions are written [here](https://github.com/wsldl-pg/ArchW-docs/blob/main/How-to-Setup.md).

### `ssh-agent` systemd

`ssh-agent.service` is installed to `~/.config/systemd/user/`.

To activate this service, the systemd user instance must be enabled by the following command:

```console
sudo systemctl enable "user@$UID"
sudo systemctl start "user@$UID"
```

or automatic start-up by the following command:

```console
sudo loginctl enable-linger $UID
```

### navi

Add cheatsheets from <https://github.com/drop-stones/cheats/tree/main>.

```console
navi repo add https://github.com/drop-stones/cheats.git
```
