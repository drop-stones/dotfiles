kernel_release=$(uname -r 2> /dev/null)
if [[ $kernel_release != *"WSL2"* ]]; then
  return
fi

function isWinDir {
  case $PWD/ in
  /mnt/*) return $(true) ;;
  *) return $(false) ;;
  esac
}

cmds=(
  # Version Control System
  "git"
  "lazygit"
  # Editor
  "nvim"
  # Display files/directories
  "bat"
  "dust"
  "eza"
  # Search Files/Text
  "fd"
  "rg"
  # Fuzzy Finder
  "fzf"
  # Command Runner
  "just"
)

for cmd in $cmds; do
  function $cmd() {
    if isWinDir; then
      $0.exe $@
    else
      /usr/bin/$0 $@
    fi
  }
done
