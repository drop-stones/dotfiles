if [[ -z $commands[zoxide] ]]; then
  echo '[zsh] zoxide not found, please install it from https://github.com/ajeetdsouza/zoxide'
else
  _evalcache zoxide init zsh # eval "$(zoxide init zsh)"
fi
