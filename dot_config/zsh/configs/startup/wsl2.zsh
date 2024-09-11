# Do noghing if not WSL2
kernel_release=$(uname -r 2>/dev/null)
if [[ $kernel_release != *"WSL2"* ]]; then
  return
fi

typeset -A exclude_set=(
  ["chezmoi"]="/usr/bin/chezmoi"
  ["vivid"]="/usr/bin/vivid"
)

# Call windows exe if in windows filesystem
for cmd cmd_path in "${(@kv)commands}"; do
  # Check the command exist in both windows and WSL2
  if [[ $cmd_path != "/mnt/"* ]] && (( $+commands[$cmd.exe] )) && (( !$+exclude_set[$cmd] )); then
    function $cmd() {
      if [[ $PWD == "/mnt/"* ]]; then
          $0.exe $@
      else
        /usr/bin/$0 $@
      fi
    }
  fi
done
