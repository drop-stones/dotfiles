. "$PSScriptRoot/utils.ps1"

##############################################
# rustup
##############################################

function Test-IsRustupComponentInstalled([string] $Component) {
  if (rustup component list --installed | Select-String -Quiet $Component) {
    return $true
  } else {
    return $false
  }
}

function Test-IsRustupComponentAvailable([string] $Component) {
  if (rustup component list | Select-String -Quiet $Component) {
    return $true
  } else {
    return $false
  }
}

function Add-RustupComponent([string[]] $Components) {
  rustup component add $Components
}

function Add-RustupComponentList([string] $PackageList) {
  Install-Packages $PackageList (Get-Command Test-IsRustupComponentInstalled).ScriptBlock (Get-Command Test-IsRustupComponentAvailable).ScriptBlock (Get-Command Add-RustupComponent).ScriptBlock
}

function Install-RustupToolchains {
  # Install toolchain
  if (rustup toolchain list | Select-String -Quiet "no installed toolchains") {
    Write-LogMessage -b "[install] " "install rust toolchain..."
    rustup toolchain install --no-self-update stable
  } else {
    Write-LogMessage -y "[skip] " "rust toolchain is already installed"
  }

  # Set default toolchain
  rustup default 2>&1 | Out-Null
  if ($LASTEXITCODE -ne 0) {
    Write-LogMessage -b "[default] " "set stable to default toolchain"
    rustup default stable
  } else {
    Write-LogMessage -y "[skip] " "default toolchain is already set"
  }
}
