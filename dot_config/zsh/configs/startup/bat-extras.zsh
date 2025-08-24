# Do nothing if msys2
is-msys2 && return 0

_evalcache batman --export-env
