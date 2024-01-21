if (( $+commands[navi] )); then
  eval "$(navi widget zsh)"
else
  echo '[zsh] navi not found, please install it from https://github.com/denisidoro/navi.git'
fi
