# Language/locale
set -gx LANG en_US.UTF-8

# Editor
set -gx EDITOR nvim
set -gx VISUAL $EDITOR
set -gx GIT_EDITOR $EDITOR
set -gx GIT_SEQUENCE_EDITOR $EDITOR # used by `git rebase -i`

# Truecolor hint for TUI apps
set -gx COLORTERM truecolor
