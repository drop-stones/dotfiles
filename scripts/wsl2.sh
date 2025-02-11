script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# wsl2
##############################################

function is_wsl2() {
  if uname -r | grep --quiet "WSL2"; then
    return 0
  else
    return 1
  fi
}

function add_wslu_server() {
  if ! is_wsl2; then
    return 0
  fi

  if ! pacman -Qi wslu >/dev/null 2>&1; then
    print_log -b "[add] " "wslu server..."
    sudo pacman -S --noconfirm wget
    wget https://pkg.wslutiliti.es/public.key
    sudo pacman-key --add public.key
    sudo pacman-key --lsign-key 2D4C887EB08424F157151C493DD50AA7E055D853
    grep -qxF 'Server = https://pkg.wslutiliti.es/arch' /etc/pacman.conf || sudo sh -c "printf '\n[wslutilities]\nServer = https://pkg.wslutiliti.es/arch' >>/etc/pacman.conf"
    rm public.key
  else
    print_log -y "[skip] " "wslu server is already added"
  fi
}
