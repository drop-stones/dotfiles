if [[ -z $commands[mise] ]]; then
  echo '[zsh] mise not found, please install it from https://github.com/jdx/mise'
elif ! is-msys2; then
  _evalcache mise activate zsh # eval $(mise activate zsh)
else
  # TODO: support msys2 (windows-style path is not compatible)
fi
