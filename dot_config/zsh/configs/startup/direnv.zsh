# Do not use `direnv` in msys due to path problem
if [[ -n "$MSYSTEM" ]]; then
  return
fi

_evalcache direnv hook zsh
