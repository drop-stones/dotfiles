if [[ "$OSTYPE" == "msys" ]]; then
  return
fi

if [[ -z $commands[navi] ]]; then
  echo '[zsh] navi not found, please install it from https://github.com/denisidoro/navi.git'
else
  # change keybind from '^g' to '^n'
  eval "$(navi widget zsh | sed 's/\^g/\^n/g')"
fi
