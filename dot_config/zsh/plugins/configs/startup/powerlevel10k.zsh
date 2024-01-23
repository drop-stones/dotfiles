autoload -Uz promptinit && promptinit && prompt powerlevel10k

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f "${ZDOTDIR:-~}/plugins/prompt/p10k.zsh" ]] || source "${ZDOTDIR:-~}/plugins/prompt/p10k.zsh"
