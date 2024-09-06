if (( $+commands[zoxide] )); then
  _evalcache zoxide init zsh # eval "$(zoxide init zsh)"
else
  echo '[zsh] zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
fi
