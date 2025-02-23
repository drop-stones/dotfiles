script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# SurfingKeys
##############################################

function install_surfingkeys_config() {
  cd "$HOME/.local/share/surfingkeys-config/"
  print-log -b "[install] " "npm packages"
  npm install

  if npm run install >/dev/null; then
    print-log -b "[install] " "surfingkeys.js to $HOME/.config/surfingkeys.js"
  else
    print-log -r "[error] " "failed to install surfingkeys.js"
  fi
}
