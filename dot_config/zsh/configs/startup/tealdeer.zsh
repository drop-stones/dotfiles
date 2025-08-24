export TEALDEER_CONFIG_DIR=~/.config/tealdeer/

# For WSL2
if is-wsl2; then
  list-add WSLENV "TEALDEER_CONFIG_DIR/wp"
fi
