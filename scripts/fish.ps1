. "$PSScriptRoot/utils.ps1"

##############################################
# fish
##############################################

function Update-Fish {
  Write-LogMessage -b "[update] " "fisher update"
  msys2 -shell fish -lc "fisher update"
}
