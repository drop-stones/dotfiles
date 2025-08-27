script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# fish
##############################################

function update_fish() {
  print_log -b "[symlink] " "fisher update"
  fish -lc "fisher update"
}
