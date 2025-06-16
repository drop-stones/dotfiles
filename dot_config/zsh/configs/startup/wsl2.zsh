# Do noghing if not WSL2
kernel_release=$(uname -r 2>/dev/null)
if [[ $kernel_release != *"WSL2"* ]]; then
  return
fi

WSLENV=$WSLENV\:LS_COLORS/w

typeset -A exclude_set=(
  ["chezmoi"]=
  ["fzf"]= # for fzf-tab
  ["vivid"]=
  ["yazi"]= # ANSI escape sequences by mouse events
  ["direnv"]=
  ["mise"]=
  ["fd"]= # Change path separator
)

# Call windows exe if in windows filesystem
for cmd cmd_path in "${(@kv)commands}"; do
  # Check the command exist in both windows and WSL2
  if [[ $cmd_path != "/mnt/"* ]] && (( $+commands[$cmd.exe] )) && (( !$+exclude_set[$cmd] )); then
    function $cmd() {
      if [[ $(realpath $PWD) == "/mnt/"* ]]; then
        command $0.exe $@
      else
        command $0 $@
      fi
    }
  fi
done

# fd
function fd() {
  if [[ $(realpath $PWD) == "/mnt/"* ]]; then
    command fd.exe --path-separator '/' $@
  else
    command fd $@
  fi
}
