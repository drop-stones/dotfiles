# Register a widget to paste clipboard content using Ctrl + V
function zle_paste_clipboard() {
  local clipboard_text
  clipboard_text=$(get_clipboard_content)

  # Insert clipboard content at the cursor position
  if [[ $? -eq 0 && -n "$clipboard_text" ]]; then
    LBUFFER+="$clipboard_text"
  else
    zle -M "Failed to paste clipboard content"
    return 1
  fi
}

# Register the widget
zle -N zle_paste_clipboard

# Bind Ctrl + V to the widget
bindkey '^V' zle_paste_clipboard
