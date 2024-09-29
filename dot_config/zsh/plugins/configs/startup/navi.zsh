if [[ "$OSTYPE" == "msys" ]]; then
  return
fi

if [[ -z $commands[navi] ]]; then
  echo '[zsh] navi not found, please install it from https://github.com/denisidoro/navi.git'
else
  _evalcache navi widget zsh # eval "$(navi widget zsh)"
fi
