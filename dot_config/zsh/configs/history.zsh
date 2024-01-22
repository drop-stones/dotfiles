# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
export HIST_STAMPS="yyyy-mm-dd"

# path of the history file
export HISTFILE="${HOME}/.zsh_history"

# the number of commands that are loaded into memory from the history file
export HISTSIZE=10000

# the number of commands that are sotred in zsh history file
export SAVEHIST=100000

# append commands immediately
setopt inc_append_history

# ignore all duplicated commands history file
setopt hist_ignore_all_dups

# ignore commands that start with space
setopt hist_save_no_dups

# reduce extra blanks
setopt hist_reduce_blanks

# share command history data
setopt share_history
