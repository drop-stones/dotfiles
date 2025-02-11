##############################################
# Print Utilities
##############################################

function print_log() {
  declare -A decorations=(
    [-r]="\e[31m{}\e[0m" # Red
    [-g]="\e[32m{}\e[0m" # Green
    [-y]="\e[33m{}\e[0m" # Yellow
    [-b]="\e[34m{}\e[0m" # Blue
    [-m]="\e[35m{}\e[0m" # Magenta
    [-c]="\e[36m{}\e[0m" # Blue
    [-w]="\e[37m{}\e[0m" # White
    [-stat]="\e[4;30;46m {} \e[0m :: "
    [-crit]="\e[30;41m {} \e[0m :: "
    [-warn]="WARNING :: \e[30;43m {} \e[0m :: "
    [-sec]="\e[32m[{}] \e[0m"
    [-err]="ERROR :: \e[4;31m{} \e[0m"
  )

  while (("$#")); do
    if [[ ${decorations[$1]} ]]; then
      echo -ne "${decorations[$1]//\{\}/$2}"
      shift 2
    else
      echo -ne "$1"
      shift
    fi
  done
  echo "" # new line
}

##############################################
# Package Install Utilities
##############################################

function install_packages() {
  local package_list=$1
  local package_installed_func=$2
  local package_available_func=$3
  local install_package_func=$4

  local install_packages=()

  while read -r package; do
    local package="${package// /}"
    if [ -z "$package" ]; then
      continue
    fi

    if $package_installed_func "$package"; then
      print_log -y "[skip] " "$package"
    elif $package_available_func "$package"; then
      print_log -b "[queue] " -b "$package"
      install_packages+=("$package")
    else
      print_log -r "[error] " "unknown package $package"
    fi
  done < <(cut -d '#' -f 1 "$package_list")

  if [[ ${#install_packages[@]} -gt 0 ]]; then
    $install_package_func "${install_packages[@]}"
  fi
}

##############################################
# CLI Utilities
##############################################

function get_command_path() {
  if command -v which >/dev/null 2>&1; then
    which wslview
  else
    type -p wslview
  fi
}

##############################################
# Symlink Utilities
##############################################

function ensure_symlink() {
  local target_path="$1"
  local link_path="$2"

  if [ -e "$link_path" ]; then
    if [ ! -L "$link_path" ]; then
      print_log -b "[remove] " "$link_path..."
      if ! rm -rf "$link_path"; then
        print_log -r "[error] " "failed to remove $link_path"
        return 1
      fi
    else
      print_log -y "[skip] " "symlink already exists: $link_path -> $target_path"
      return 0
    fi
  fi

  print_log -b "[symlink] " "create symlink: $link_path -> $target_path"
  if ! sudo ln -s "$target_path" "$link_path"; then
    print_log -r "[error] " "failed to create symlink"
    return 1
  fi
}
