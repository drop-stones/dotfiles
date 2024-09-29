# Read config file
# TODO: Add comment when ver 0.55.0 is released
export FZF_DEFAULT_OPTS_FILE=~/.config/fzf/config

export FZF_DEFAULT_COMMAND="if [[ \$(realpath \$PWD) == \"/mnt/\"* ]]; then
  command fd.exe --color=always --strip-cwd-prefix --type f --type d --hidden --follow --exclude .git --path-separator='/'
else
  command fd --color=always --strip-cwd-prefix --type f --type d --hidden --follow --exclude .git --path-separator='/'
fi"

# For WSL2
export WSLENV=FZF_DEFAULT_COMMAND:$WSLENV
