script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# SurfingKeys
##############################################

function install_surfingkeys_config() {
  cd "$HOME/.local/share/surfingkeys-config/" || exit

  if npm install >/dev/null; then
    print_log -b "[install] " "npm packages"
  else
    print_log -r "[error] " "failed to install npm packages"
  fi

  if npm run install >/dev/null; then
    print_log -b "[install] " "surfingkeys.js to $HOME/.config/surfingkeys.js"
  else
    print_log -r "[error] " "failed to install surfingkeys.js"
  fi

  if npm run install -- --vivaldi >/dev/null; then
    print_log -b "[install] " "surfingkeys.vivaldi.js to $HOME/.config/surfingkeys.vivaldi.js"
  else
    print_log -r "[error] " "failed to install surfingkeys.vivaldi.js"
  fi

  if npm run configure-vivaldi >/dev/null; then
    print_log -b "[configure] " "vivaldi preferences"
  else
    print_log -r "[error] " "failed to configure vivaldi preferences"
  fi

  cd - >/dev/null || exit
}
