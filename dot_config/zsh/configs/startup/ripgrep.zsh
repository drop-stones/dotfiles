# Read config file
export RIPGREP_CONFIG_PATH=~/.config/ripgrep/config

# For WSL2
if is-wsl2; then
  list-add WSLENV "RIPGREP_CONFIG_PATH/wp"
fi
