script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# pacman
##############################################

function package_installed() {
  local package=$1
  if pacman -Qi "${package}" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function package_available() {
  local package=$1
  if pacman -Si "${package}" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function install_package() {
  local packages=("$@")
  sudo pacman -S --noconfirm "${packages[@]}"
}

function install_package_list() {
  local package_list=$1
  install_packages "$package_list" package_installed package_available install_package
}

##############################################
# rustup
##############################################

function setup_rustup() {
  # install toolchain
  if rustup toolchain list | grep --quiet "no installed toolchains"; then
    print_log -b "[install] " "install rust toolchain..."
    rustup toolchain install --no-self-update stable
  else
    print_log -y "[skip] " "rust toolchain is already installed"
  fi

  # set default toolchain
  if ! rustup default >/dev/null 2>&1; then
    print_log -b "[default] " "set stable to default toolchain"
    rustup default stable
  else
    print_log -y "[skip] " "default toolchain is already set"
  fi
}
