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

  if npm run install -- --vivaldi >/dev/null; then
    print-log -b "[install] " "surfingkeys.vivaldi.js to $HOME/.config/surfingkeys.vivaldi.js"
  else
    print-log -r "[error] " "failed to install surfingkeys.vivaldi.js"
  fi

  print-log -b "[setup] " "vivaldi settings"
  npm run setup-vivaldi

  cd -
}
