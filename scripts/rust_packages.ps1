. "$PSScriptRoot/utils.ps1"

##############################################
# cargo
##############################################

function Test-IsCargoPackageInstalled([string] $Package) {
  if (cargo install --list --quiet | Select-String -Quiet $Package) {
    return $true
  } else {
    return $false
  }
}

function Test-IsCargoPackageAvailable([string] $Package) {
  if (cargo search --quiet $Package | Select-String -Quiet $Package) {
    return $true
  } else {
    return $false
  }
}

function Install-CargoPackage([string[]] $Packages) {
  cargo install --locked $Packages
}

function Install-CargoBinaryPackage([string[]] $Packages) {
  cargo binstall --locked --no-confirm $Packages
}

function Install-CargoBinstall() {
  if (Test-IsCargoPackageInstalled cargo-binstall) {
    Write-LogMessage -y "[skip] " "cargo-binstall"
  } else {
    Install-CargoPackage cargo-binstall
  }
}

function Install-CargoPackageList([string] $PackageList) {
  Install-Packages $PackageList (Get-Command Test-IsCargoPackageInstalled).ScriptBlock (Get-Command Test-IsCargoPackageAvailable).ScriptBlock (Get-Command Install-CargoPackage).ScriptBlock
}

function Install-CargoBinaryPackageList([string] $PackageList) {
  Install-Packages $PackageList (Get-Command Test-IsCargoPackageInstalled).ScriptBlock (Get-Command Test-IsCargoPackageAvailable).ScriptBlock (Get-Command Install-CargoBinaryPackage).ScriptBlock
}

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
