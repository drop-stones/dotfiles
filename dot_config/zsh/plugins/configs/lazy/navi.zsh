# Do nothing if msys2
is-msys2 && return 0

if [[ -z $commands[navi] ]]; then
  echo '[zsh] navi not found, please install it from https://github.com/denisidoro/navi.git'
else
  # change keybind from '^g' to '^n'
  eval "$(navi widget zsh | sed 's/\^g/\^n/g')"
fi
