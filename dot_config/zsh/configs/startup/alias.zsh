# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# eza
alias ls="eza --git --icons --color=always --group-directories-first"

# zoxide
alias cd="z"

# help
alias -g -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -g -- --help='--help 2>&1 | bat --language=help --style=plain'

chezmoi_update_all() {
  chezmoi state delete-bucket --bucket=scriptState
  chezmoi update
}
