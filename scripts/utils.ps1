##############################################
# Print Utilities
##############################################

function Write-LogMessage([Parameter(ValueFromRemainingArguments=$true)] [string[]] $Args) {
  class Option {
    [string] $ForegroundColor
    [string] $BackgroundColor
    [string] $PreMessage
    [string] $PostMessage
    Option([string] $ForegroundColor, [string] $BackgroundColor, [string] $PreMessage, [string] $PostMessage) {
      $this.ForegroundColor = $ForegroundColor
      $this.BackgroundColor = $BackgroundColor
      $this.PreMessage = $PreMessage
      $this.PostMessage = $PostMessage
    }
  }

  $DecorationMap = @{
    "-r" = [Option]::new("Red", $null, $null, $null)
    "-g" = [Option]::new("Green", $null, $null, $null)
    "-y" = [Option]::new("Yellow", $null, $null, $null)
    "-b" = [Option]::new("Blue", $null, $null, $null)
    "-c" = [Option]::new("Cyan", $null, $null, $null)
    "-m" = [Option]::new("Magenta", $null, $null, $null)
    "-w" = [Option]::new("White", $null, $null, $null)
    "-stat" = [Option]::new("Black", "Cyan", " ", " ")
    "-crit" = [Option]::new("Black", "Red", " ", " ")
    "--warning" = [Option]::new("Black", "Yellow", "WARNING :: ", " :: ")
    "-sec" = [Option]::new("Green", $null, "[", "]")
    "--error" = [Option]::new("Red", $null, "ERROR :: ", $null)
  }
  
  $Index = 0
  while ($Index -lt $Args.Length) {
    if ($DecorationMap.ContainsKey($Args[$Index])) {
      [Option] $Decoration = $DecorationMap[$Args[$Index]]
      [string] $Text = $Args[$Index + 1]

      # Pre Message
      if ($Decoration.PreMessage) {
        Write-Host -NoNewline $Decoration.PreMessage
      }

      # Coloring
      $Options = @{ NoNewline = $true }
      if ($Decoration.ForegroundColor) {
        $Options["ForegroundColor"] = $Decoration.ForegroundColor 
      }
      if ($Decoration.BackgroundColor) {
        $Options["BackgroundColor"] = $Decoration.BackgroundColor 
      }
      Write-Host $Text @Options

      # Post Message
      if ($Decoration.PostMessage) {
        Write-Host -NoNewline $Decoration.PostMessage
      }

      $Index += 2
    } else {
      Write-Host -NoNewline $Args[$Index]
      $Index += 1
    }
  }
  Write-Host "" # new line
}

##############################################
# Package Install Utilities
##############################################

function Install-Packages([string] $PackageList, [scriptblock] $PackageInstalledFunc, [scriptblock] $PackageAvailableFunc, [scriptblock] $InstallPackageFunc) {
  $InstallPackages = @()

  Get-Content $PackageList | ForEach-Object {
    $Package = ($_ -split "#")[0].Trim()
    if (-not $Package) {
      return
    }

    if (& $PackageInstalledFunc $Package) {
      Write-LogMessage -y "[skip] " "$Package"
    } elseif (& $PackageAvailableFunc $Package) {
      Write-LogMessage -b "[queue] " "$Package"
      $InstallPackages += $Package
    } else {
      Write-LogMessage -r "[error] " "unknown package $package"
    }
  }

  if ($InstallPackages.Count -gt 0) {
    & $InstallPackageFunc $InstallPackages
  }
}

##############################################
# Symlink Utilities
##############################################

function New-SymlinkIfMissing([string] $TargetPath, [string] $LinkPath) {
  if (Test-Path -Path $LinkPath) {
    $LinkItem = Get-Item -LiteralPath $LinkPath

    # Delete path if it is not symlink
    if (-not ($LinkItem.Attributes -band [IO.FileAttributes]::ReparsePoint)) {
      Write-LogMessage -b "[remove] " "$LinkPath..."
      try {
        Remove-Item -LiteralPath $LinkPath -Force -Recurse
      } catch {
        Write-LogMessage -r "[error] " "failed to remove ${LinkPath}: $_"
        return
      }
    } else {
      Write-LogMessage -y "[skip] " "symlink already exists: $LinkPath -> $TargetPath"
      return
    }
  } 

  # Create symlink
  Write-LogMessage -b "[symlink] " "create symlink: $LinkPath -> $TargetPath"
  try {
    New-Item -ItemType SymbolicLink -Path $LinkPath -Target $TargetPath | Out-Null
  } catch {
    Write-LogMessage -r "[error] " "failed to create symlink: $_"
  }
}
