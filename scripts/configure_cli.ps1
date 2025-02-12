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

##############################################
# navi
##############################################

function Install-NaviRepository([string] $Url, [string] $Name) {
  $CheatPath = navi info cheats-path
  $InstallDir = "$CheatPath/$Name"

  if (Test-Path $InstallDir) {
    Write-LogMessage -b "[pull] " "$name..."
    git -C "$InstallDir" pull 2>&1 | Out-Null
  } else {
    Write-LogMessage -b "[clone] " "$name..."
    git clone "$Url" "$InstallDir"
  }
}
