. "$PSScriptRoot/utils.ps1"

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
