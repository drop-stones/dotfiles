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

##############################################
# navi
##############################################

function install_navi_repository() {
  local url=$1
  local name=$2

  local cheatpath install_dir
  cheatpath=$(navi info cheats-path)
  install_dir="$cheatpath/$name"

  if [[ -e "$install_dir" ]]; then
    print_log -b "[pull] " "$name..."
    git -C "$install_dir" pull >/dev/null
  else
    print_log -b "[clone] " "$name..."
    git clone "$url" "$install_dir"
  fi
}
