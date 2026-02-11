script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# bat
##############################################

function build_bat_cache() {
  if bat cache --build >/dev/null; then
    print_log -b "[build] " "build bat cache..."
  else
    print_log -r "[error] " "failed to build bat cache"
  fi
}
