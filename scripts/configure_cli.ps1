$ScriptDir = "$env:USERPROFILE/.local/share/chezmoi/scripts"
if (-not (Test-Path "$ScriptDir/utils.ps1")) {
  Write-Host "Error: unable to source utils.ps1..." -ForegroundColor Red
  return 1
}
. "$ScriptDir/utils.ps1"

##############################################
# bat
##############################################

function Build-BatCache {
  if (bat cache --build) {
    Write-LogMessage -b "[build] " "build bat cache..."
  } else {
    Write-LogMessage -r "[error] " "failed to build bat cache"
  }
}
