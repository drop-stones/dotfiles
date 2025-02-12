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
  if (scoop list $Package 6>&1 | Select-Object -Skip 1 | Select-String -Quiet $Package) {
    return $true
  } else {
    return $false
  }
}

function Test-IsPackageAvailable([string] $Package) {
  if (scoop search $Package 6>&1 | Select-Object -Skip 1 | Select-String -Quiet $Package) {
    return $true
  } else {
    return $false
  }
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
  if ((winget list) -match 'winget$' | Select-String -Quiet $Package) {
    return $true
  } else {
    return $false
  }
}

function Test-IsWingetPackageAvailable([string] $Package) {
  if (winget search $Package | Out-Null) {
    return $true
  } else {
    return $false
  }
}

function Install-WingetPackage([string[]] $Packages) {
  winget install $Packages
}

function Install-WingetPackageList([string] $PackageList) {
  Install-Packages $PackageList (Get-Command Test-IsWingetPackageInstalled).ScriptBlock (Get-Command Test-IsWingetPackageAvailable).ScriptBlock (Get-Command Install-WingetPackage).ScriptBlock
}
