$ScriptDir = "$env:USERPROFILE/.local/share/chezmoi/scripts"
if (-not (Test-Path "$ScriptDir/utils.ps1")) {
  Write-Host "Error: unable to source utils.ps1..." -ForegroundColor Red
  return 1
}
. "$ScriptDir/utils.ps1"

##############################################
# scoop
##############################################

function Add-ScoopBucket([string] $Bucket, [string] $Url) {
  if (-not (scoop bucket list | Select-String -Quiet $Bucket)) {
    Write-LogMessage -b "[add] " "add $Bucket bucket"
    scoop bucket add $Bucket $Url
  } else {
    Write-LogMessage -y "[skip] " "$Bucket bucket is already added"
  }
}

function Test-IsPackageInstalled([string] $Package) {
  # skip header by `Select-Object -Skip 1`
  scoop list $Package 6>&1 | Select-Object -Skip 1 | Select-String -Quiet $Package
}

function Test-IsPackageAvailable([string] $Package) {
  scoop search $Package 6>&1 | Select-Object -Skip 1 | Select-String -Quiet $Package
}

function Install-Package([string[]] $Packages) {
  scoop install $Packages
}

function Install-PackageList([string] $PackageList) {
  Install-Packages $PackageList (Get-Command Test-IsPackageInstalled).ScriptBlock (Get-Command Test-IsPackageAvailable).ScriptBlock (Get-Command Install-Package).ScriptBlock
}

##############################################
# winget
##############################################

function Test-IsWingetPackageInstalled([string] $Package) {
  (winget list) -match 'winget$' | Select-String -Quiet $Package
}

function Test-IsWingetPackageAvailable([string] $Package) {
  winget search $Package | Out-Null
  $LASTEXITCODE -eq 0
}

function Install-WingetPackage([string[]] $Packages) {
  winget install $Packages
}

function Install-WingetPackageList([string] $PackageList) {
  Install-Packages $PackageList (Get-Command Test-IsWingetPackageInstalled).ScriptBlock (Get-Command Test-IsWingetPackageAvailable).ScriptBlock (Get-Command Install-WingetPackage).ScriptBlock
}

##############################################
# msys2
##############################################

function Test-IsMsys2PackageInstalled([string] $Package) {
  msys2 -lc "pacman -Qi $Package &>/dev/null"
  return $LASTEXITCODE -eq 0
}

function Test-IsMsys2PackageAvailable([string] $Package) {
  msys2 -lc "pacman -Si $Package &>/dev/null"
  return $LASTEXITCODE -eq 0
}

function Install-Msys2Package([string] $Package) {
  msys2 -lc "pacman -S --noconfirm $Package"
}

function Install-Msys2PackageList([string] $PackageList) {
  msys2 -lc "pacman -Sy" # Update package databases information
  Install-Packages $PackageList (Get-Command Test-IsMsys2PackageInstalled).ScriptBlock (Get-Command Test-IsMsys2PackageAvailable).ScriptBlock (Get-Command Install-Msys2Package).ScriptBlock
}
