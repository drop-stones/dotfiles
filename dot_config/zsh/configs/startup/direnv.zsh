# Do not use `direnv` in msys due to path problem
is-msys2 && return 0

_evalcache direnv hook zsh
