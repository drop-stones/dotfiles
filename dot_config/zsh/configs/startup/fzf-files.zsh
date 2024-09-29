function fzf-cd() {
  local selected_dir
  if [[ $(realpath $PWD) == "/mnt/"* ]]; then
    selected_dir=$(command fd.exe --type d --color=always --path-separator='/' . $1 | fzf +m --height 50% --preview 'command eza.exe --git --icons --color=always --group-directories-first --tree {}')
  else
    selected_dir=$(command fd --type d --color=always --path-separator='/' . $1 | fzf +m --height 50% --preview 'command eza --git --icons --color=always --group-directories-first --tree {}')
  fi
  if [[ -n "$selected_dir" ]]; then
    # Change to the selected directory
    z "$selected_dir" || return 1
  fi
}
