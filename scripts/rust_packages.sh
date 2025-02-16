script_dir="$HOME/.local/share/chezmoi/scripts"
if ! source "${script_dir}/utils.sh"; then
  echo "Error: unable to source utils.sh..."
  exit 1
fi

##############################################
# cargo
##############################################

function cargo_package_installed() {
  local package=$1
  if cargo install --list --quiet | grep --quiet --fixed-strings "$package"; then
    return 0
  else
    return 1
  fi
}

function cargo_package_available() {
  local package=$1
  if cargo search --quiet "$package" | grep --quiet --fixed-strings "$package" &>/dev/null; then
    return 0
  else
    return 1
  fi
}

function install_cargo_package() {
  local packages=("$@")
  print_log -b "[install] " "cargo install packages..."
  cargo install --locked "${packages[@]}"
}

function binstall_cargo_package() {
  local packages=("$@")
  print_log -b "[install] " "cargo binstall packages..."
  cargo binstall --locked --no-confirm "${packages[@]}"
}

function install_cargo_binstall() {
  if cargo_package_installed "cargo-binstall"; then
    print_log -y "[skip] " "cargo-binstall"
  else
    install_cargo_package "cargo-binstall"
  fi
}

function install_cargo_package_list() {
  local cargo_install_package_list=$1
  install_packages "$cargo_install_package_list" cargo_package_installed cargo_package_available install_cargo_package
}

function binstall_cargo_package_list() {
  local cargo_binstall_package_list=$1
  install_packages "$cargo_binstall_package_list" cargo_package_installed cargo_package_available binstall_cargo_package
}

##############################################
# rustup
##############################################

function rustup_component_installed() {
  local component=$1
  if rustup component list --installed | grep --quiet --fixed-strings "$component"; then
    return 0
  else
    return 1
  fi
}

function rustup_component_available() {
  local component=$1
  if rustup component list | grep --quiet --fixed-strings "$component"; then
    return 0
  else
    return 1
  fi
}

function add_rust_component() {
  local components=("$@")
  rustup component add "${components[@]}"
}

function add_rust_component_list() {
  local rust_component_list=$1
  install_packages "$rust_component_list" rustup_component_installed rustup_component_available add_rust_component
}
