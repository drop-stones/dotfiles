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
      # NOTE: Pipe `|` does not work with `rg.exe` and `fzf`, so use `rg` instead
      command rg --column --line-number --no-heading --color=always --smart-case -e "$1" |
        fzf --delimiter :  --preview "command bat.exe --color=always --style=numbers --line-range \$(( \$(echo {2}) - 10 < 0 ? 0 : \$(echo {2}) - 10 )): -- {1} | command rg.exe --ignore-case --color=always --no-line-number --context 10 '$1'"
    ))
  else
    IFS=$'\n' files=($(
      command rg --column --line-number --no-heading --color=always --smart-case -e "$1" |
        fzf --delimiter :  --preview "command bat --color=always --style=numbers --line-range \$(( \$(echo {2}) - 10 < 0 ? 0 : \$(echo {2}) - 10 )): -- {1} | command rg --ignore-case --color=always --no-line-number --context 10 '$1'"
    ))
  fi
  if [[ -n "$files" ]]; then
    nvim_cmd="nvim -c \""

    for file_info in "${files[@]}"; do
      parts=("${(@s/:/)file_info}")

      file_path="${parts[1]}"
      line_number="${parts[2]}"
      column_number="${parts[3]}"

      nvim_cmd="$nvim_cmd :e $file_path | :cal cursor($line_number, $column_number) |"
    done
    nvim_cmd="${nvim_cmd% |}\""

    eval $nvim_cmd
  fi
}
