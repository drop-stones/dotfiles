# Register a widget to paste clipboard content using Ctrl + V
# function zle_paste_clipboard() {
#   local clipboard_text
#
#   if command -v pbpaste &>/dev/null; then
#     # macOS: Use pbpaste
#     clipboard_text=$(pbpaste)
#   elif command -v xclip &>/dev/null; then
#     # Linux: Use xclip
#     clipboard_text=$(xclip -selection clipboard -o 2>/dev/null)
#   elif command -v xsel &>/dev/null; then
#     # Linux: Use xsel
#     clipboard_text=$(xsel --clipboard --output 2>/dev/null)
#   elif command -v win32yank.exe &>/dev/null; then
#     # WSL2: Use win32yank
#     clipboard_text=$(win32yank.exe -o 2>/dev/null)
#   elif [[ "$OS" == "Windows_NT" ]]; then
#     # Windows: Use PowerShell Get-Clipboard
#     clipboard_text=$(powershell.exe -Command "Get-Clipboard" 2>/dev/null | tr -d '\r')
#   else
#     # Display an error message if no clipboard command is available
#     zle -M "No clipboard command available"
#     return 1
#   fi
#
#   # Insert clipboard content at the cursor position
#   if [[ -n $clipboard_text ]]; then
#     LBUFFER+="$clipboard_text"
#   fi
# }

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
