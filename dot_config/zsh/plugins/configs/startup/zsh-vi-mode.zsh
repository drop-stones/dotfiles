# # Do the initialization when the script is sourced (i.e. Initialize instantly)
ZVM_INIT_MODE=sourcing

# Only changing the escape key to `jk` in insert mode, we still
# keep using the default keybindings `^[` in other modes
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

# Surround
ZVM_VI_SURROUND_BINDKEY=s-prefix

# Highlight
ZVM_VI_HIGHLIGHT_BACKGROUND=#283457

# https://github.com/jeffreytse/zsh-vi-mode/issues/159
setopt re_match_pcre
