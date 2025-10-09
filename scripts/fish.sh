script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# fish
##############################################

function change_shell_to_fish() {
  local current_shell
  current_shell=$(basename "$SHELL")

  # Skip if already using fish
  if [[ "$current_shell" == "fish" ]]; then
    print_log -y "[skip] " "default shell is already fish"
    return 0
  fi

  local fish_exe
  fish_exe=$(command -v fish)
  if [[ -z "$fish_exe" ]]; then
    print_log -r "[error] " "fish not found in PATH"
    return 1
  fi

  local fish_path
  fish_path=$(readlink -f "$fish_exe")

  print_log -b "[shell] " "change default shell to fish..."
  if chsh -s "$fish_path"; then
    print_log -g "[shell] " "default shell changed to fish successfully"
  else
    print_log -r "[error] " "failed to change default shell"
  fi
}

function update_fish() {
  print_log -b "[symlink] " "fisher update"
  fish -lc "fisher update"
}
