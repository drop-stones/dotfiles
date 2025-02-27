$ScriptDir = "$env:USERPROFILE/.local/share/chezmoi/scripts"
if (-not (Test-Path "$ScriptDir/utils.ps1")) {
  Write-Host "Error: unable to source utils.ps1..." -ForegroundColor Red
  return 1
}
. "$ScriptDir/utils.ps1"

##############################################
# SurfingKeys
##############################################

function Install-SurfingKeysConfig {
  Push-Location
  Set-Location "$HOME/.local/share/surfingkeys-config/"

  Write-LogMessage -b "[install] " "npm packages"
  npm install

  if (npm run install) {
    Write-LogMessage -b "[install] " "surfingkeys.js to $HOME\.config\surfingkeys.js"
  } else {
    Write-LogMessage -r "[error] " "failed to install surfingkeys.js"
  }
  
  if (npm run install -- --vivaldi) {
    Write-LogMessage -b "[install] " "surfingkeys.vivaldi.js to $HOME\.config\surfingkeys.vivaldi.js"
  } else {
    Write-LogMessage -r "[error] " "failed to install surfingkeys.vivaldi.js"
  }

  Write-LogMessage -b "[setup] " "vivaldi settings"
  npm run setup-vivaldi
  Pop-Location
}
