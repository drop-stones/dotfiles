# fe [FUZZY PATTERN] - Open the selected file/directory with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fzf-editor() {
  IFS=$'\n' files=($(
    fzf --query="$1" --multi --select-1 --exit-0 --preview \
      'if [[ $(realpath $PWD) == "/mnt/"* ]]; then
        command bat.exe --color=always --style=numbers --line-range=:500 {} 2>/dev/null || command eza.exe -1 --color=always {}
      else
        command bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null || command eza -1 --color=always {}
      fi'
  ))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fef [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fzf-edit-file() {
  if [[ $(realpath $PWD) == "/mnt/"* ]]; then
    IFS=$'\n' files=($(
      command fd.exe --color=always --strip-cwd-prefix --type f --hidden --follow --exclude .git --path-separator='/' |
        fzf --query="$1" --multi --select-1 --exit-0 --preview 'command bat.exe --color=always --style=numbers --line-range=:500 {} 2>/dev/null'
    ))
  else
    IFS=$'\n' files=($(
      command fd --color=always --strip-cwd-prefix --type f --hidden --follow --exclude .git --path-separator='/' |
        fzf --query="$1" --multi --select-1 --exit-0 --preview 'command bat --color=always --style=numbers --line-range=:500 {} 2>/dev/null'
    ))
  fi
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fed [FUZZY PATTERN] - Open the selected directory with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fzf-edit-directory() {
  if [[ $(realpath $PWD) == "/mnt/"* ]]; then
    IFS=$'\n' dirs=($(
      command fd.exe --color=always --strip-cwd-prefix --type d --hidden --follow --exclude .git --path-separator='/' |
        fzf --query="$1" --multi --select-1 --exit-0 --preview 'command eza.exe -1 --color=always {}'
    ))
  else
    IFS=$'\n' dirs=($(
      command fd --color=always --strip-cwd-prefix --type d --hidden --follow --exclude .git --path-separator='/' |
        fzf --query="$1" --multi --select-1 --exit-0 --preview 'command eza -1 --color=always {}'
    ))
  fi
  [[ -n "$dirs" ]] && ${EDITOR:-vim} "${dirs[@]}"
}

# using ripgrep combined with preview
# find-in-file - usage: fif <searchTerm>
fzf-ripgrep() {
  if [ ! "$#" -gt 0 ]; then
    echo "Need a string to search for!"
    return 1
  fi
  if [[ $(realpath $PWD) == "/mnt/"* ]]; then
    IFS=$'\n' files=($(
      command rg.exe --files-with-matches --no-messages "$1" |
        fzf --preview "highlight -O ansi -l {} 2> /dev/null | command rg.exe --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || command rg.exe --ignore-case --pretty --context 10 '$1' {}"
    ))
  else
    IFS=$'\n' files=($(
      command rg --files-with-matches --no-messages "$1" |
        fzf --preview "highlight -O ansi -l {} 2> /dev/null | command rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || command rg --ignore-case --pretty --context 10 '$1' {}"
    ))
  fi
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}
