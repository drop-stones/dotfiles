export YAZI_CONFIG_HOME=~/.config/yazi

# For WSL2
if is-wsl2; then
  list-add WSLENV "YAZI_CONFIG_HOME/wp"
fi
