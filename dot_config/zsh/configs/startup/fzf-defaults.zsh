if [[ -n "$MSYSTEM" ]]; then
  FZF_PATH_SEPARATOR='//'
else
  FZF_PATH_SEPARATOR='/'
fi

# Read config file
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config

export FZF_DEFAULT_COMMAND="if [[ \$(realpath \$PWD) == \"/mnt/\"* ]]; then
  command fd.exe --color=always --strip-cwd-prefix --type f --type d --hidden --follow --exclude .git --path-separator=$FZF_PATH_SEPARATOR
else
  command fd --color=always --strip-cwd-prefix --type f --type d --hidden --follow --exclude .git --path-separator=$FZF_PATH_SEPARATOR
fi"

# For WSL2
WSLENV=$WSLENV\:FZF_DEFAULT_OPTS_FILE/wp\:FZF_DEFAULT_COMMAND/w
