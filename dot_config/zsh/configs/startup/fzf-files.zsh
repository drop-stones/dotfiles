function fzf-cd() {
  local selected_dir
  selected_dir=$(fd --type d --color=always . "$1" | fzf +m --height 50% --preview 'eza --git --icons --color=always --group-directories-first --tree {}')
  if [[ -n "$selected_dir" ]]; then
    # Change to the selected directory
    z "$selected_dir" || return 1
  fi
}
