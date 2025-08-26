# Define helper function to dot-source all .ps1 files in a given directory
function Import-Profiles([string] $Dir) {
  if (Test-Path $Dir) {
    Get-ChildItem -Path $Dir -Filter *.ps1 | ForEach-Object {
      # Dot-source each file so that its functions/aliases are loaded into the current scope
      . $_.FullName
    }
  }
}

# Base directory where custom PowerShell profiles/functions are stored
$ProfileDir = "$env:USERPROFILE/Documents/PowerShellProfile/"

# Load profile-specific scripts (general environment setup, config, etc.)
Import-Profiles (Join-Path $ProfileDir "profiles")

# Load custom functions from separate directory
Import-Profiles (Join-Path $ProfileDir "functions")

# Remove the temporary Import-Profiles helper to avoid polluting global function scope
Remove-Item -Path function:\Import-Profiles -ErrorAction SilentlyContinue
