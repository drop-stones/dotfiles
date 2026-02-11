$ScriptDir = "$env:USERPROFILE/.local/share/chezmoi/scripts"
if (-not (Test-Path "$ScriptDir/utils.ps1")) {
  Write-Host "Error: unable to source utils.ps1..." -ForegroundColor Red
  return 1
}
. "$ScriptDir/utils.ps1"

##############################################
# wsl2
##############################################

function Test-Wsl2DistroInstalled([string] $distroName) {
  # check whether WSL2 is installed
  $wsl = Get-Command wsl.exe -ErrorAction SilentlyContinue
  if (-not $wsl) {
    Write-LogMessage -r "[error] " "WSL is not installed"
    return $false
  }

  $installedDistroList = wsl.exe --list --quiet 2>$null
  if ($LASTEXITCODE -ne 0 -or -not $installedDistroList) {
    Write-LogMessage -r "[error] " "unable to get list of installed WSL distros"
    return $false
  }

  foreach ($distro in $installedDistroList) {
    if ($distro.Trim() -eq $distroName) {
      return $true
    }
  }

  return $false
}

##############################################
# NixOS
##############################################

function Install-NixOSDistro {
  $distroName = "NixOS"
  $assetName = "nixos.wsl"

  if (Test-Wsl2DistroInstalled $distroName) {
    Write-LogMessage -y "[skip] " "$distroName is already installed"
    return
  }

  Write-LogMessage -b "[install] " "installing $distroName..."

  $release = Invoke-RestMethod "https://api.github.com/repos/nix-community/NixOS-WSL/releases/latest"
  $url = ($release.assets | Where-Object name -eq $assetName | Select-Object -First 1).browser_download_url
  if (-not $url) {
    Write-LogMessage -r "[error] " "unable to find NixOS WSL image URL"
    return
  }

  Write-LogMessage -b "[download] " "downloading NixOS WSL image..."

  Invoke-WebRequest -Uri $url -OutFile $assetName

  Write-LogMessage -b "[import] " "importing $distroName into WSL2..."
  wsl.exe --install --from-file $assetName --name $distroName --no-launch

  Write-LogMessage -b "[cleanup] " "removing temporary files..."
  Remove-Item -Force $assetName

  Write-LogMessage -b "[set] " "setting defalt WSL distro to $distroName"
  wsl.exe --set-default $distroName
}
