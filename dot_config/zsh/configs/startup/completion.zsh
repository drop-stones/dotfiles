autoload -Uz compinit && compinit

_evalcache dircolors # eval "$(dircolors)"
zstyle ":completion:*" list-colors $LS_COLORS
