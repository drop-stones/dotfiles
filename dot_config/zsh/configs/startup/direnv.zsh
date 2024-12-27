# Do not use `direnv` in msys due to path problem
if [[ "$OSTYPE" == "msys" ]]; then
  return
fi

_evalcache direnv hook zsh
