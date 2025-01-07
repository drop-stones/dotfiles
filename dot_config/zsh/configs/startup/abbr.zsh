ABBR_QUIET=1

# git
abbr -S g="git"
abbr -S ga="git add"
abbr -S gst="git status"
abbr -S gb="git branch"
abbr -S --quieter -f gc="git commit --verbose"
abbr -S gco="git checkout"
abbr -S gd="git diff"
abbr -S glg="git log --stat"
abbr -S gl="git pull"
abbr -S gua="git pull && git submodule update --init --recursive"
abbr -S gsw="git-switch"
abbr -S gswd="git-switch-detach"
abbr -S gwt="git-worktree"

# lazygit
abbr -S lg="lazygit"

# eza
eza_command="eza --git --icons --color=always --group-directories-first"
abbr -S l="$eza_command"
abbr -S ll="$eza_command -l"
abbr -S la="$eza_command -la"
abbr -S lt="$eza_command --tree"

# bat
abbr -S --quieter -f cat="bat"
if [[ "$OSTYPE" != "msys" ]]; then
  abbr -S --quieter -f man="batman"
fi

# fzf
abbr -S fe="fzf-editor"
abbr -S fef="fzf-edit-file"
abbr -S fed="fzf-edit-directory"
abbr -S frg="fzf-ripgrep"
abbr -S fcd="fzf-cd"

# highlight single-word abbreviations for fast-syntax-highlighting
# https://zsh-abbr.olets.dev/advanced.html#fast-syntax-highlighting
chroma_single_word() {
  (( next_word = 2 | 8192 ))

  local __first_call="$1" __wrd="$2" __start_pos="$3" __end_pos="$4"
  local __style

  (( __first_call )) && { __style=${FAST_THEME_NAME}alias }
  [[ -n "$__style" ]] && (( __start=__start_pos-${#PREBUFFER}, __end=__end_pos-${#PREBUFFER}, __start >= 0 )) && reply+=("$__start $__end ${FAST_HIGHLIGHT_STYLES[$__style]}")

  (( this_word = next_word ))
  _start_pos=$_end_pos

  return 0
}

register_single_word_chroma() {
  local word=$1
  if [[ -n $FAST_HIGHLIGHT["chroma-$word"] ]]; then
    return 1
  fi

  FAST_HIGHLIGHT+=( "chroma-$word" chroma_single_word )
  return 0
}

if [[ -n $FAST_HIGHLIGHT ]]; then
  for abbr in ${(f)"$(abbr list-abbreviations)"}; do
    if [[ $abbr != *' '* ]]; then
      register_single_word_chroma ${(Q)abbr}
    fi
  done
fi
