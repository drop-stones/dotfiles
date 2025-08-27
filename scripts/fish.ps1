$ScriptDir = "$env:USERPROFILE/.local/share/chezmoi/scripts"
if (-not (Test-Path "$ScriptDir/utils.ps1")) {
  Write-Host "Error: unable to source utils.ps1..." -ForegroundColor Red
  return 1
}
. "$ScriptDir/utils.ps1"

##############################################
# fish
##############################################

function Update-Fish {
  Write-LogMessage -b "[update] " "fisher update"
  msys2 -shell fish -lc "fisher update"
}
