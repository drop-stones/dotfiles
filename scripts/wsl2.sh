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
