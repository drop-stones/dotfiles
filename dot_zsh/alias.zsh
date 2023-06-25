# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias lg="lazygit"

manFn() {
  $1 --help | less;
}

# if `man` not found, alias to manFn
man 2>/dev/null
if [ $? -eq 127 ]; then
  alias man=manFn
fi
