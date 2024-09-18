(( $+commands[vivid] )) && export LS_COLORS="$(vivid generate tokyonight-night)"

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# preview directory's content with eza when completing cd
kernel_release=$(uname -r 2>/dev/null)
if [[ $kernel_release != *"WSL2"* ]]; then
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
  zstyle ':fzf-tab:complete:z:*' fzf-preview 'eza -1 --color=always $realpath'
else
  zstyle ':fzf-tab:complete:cd:*' fzf-preview \
    'if [[ $(realpath $PWD) == "/mnt/"* ]]; then
        eza.exe -1 --color=always $realpath
    else
        /usr/bin/eza -1 --color=always $realpath
    fi'
  zstyle ':fzf-tab:complete:z:*' fzf-preview \
    'if [[ $(realpath $PWD) == "/mnt/"* ]]; then
        eza.exe -1 --color=always $realpath
    else
        /usr/bin/eza -1 --color=always $realpath
    fi'
fi

zstyle ':fzf-tab:*' fzf-min-height 8
