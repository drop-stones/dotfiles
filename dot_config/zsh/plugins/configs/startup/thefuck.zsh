# Do nothing if msys2
is-msys2 && return 0

if [[ -z $commands[thefuck] ]]; then
  echo '[zsh] thefuck not found, please install it from https://github.com/nvbn/thefuck'
else
  _evalcache thefuck --alias # eval "$(thefuck --alias)"
fi
