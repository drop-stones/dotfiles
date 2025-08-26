# Path to the central profile script managed outside of $PROFILE
$ProfileScript = "$env:USERPROFILE/Documents/PowerShellProfile/Profile.ps1"

# If the central profile exists, dot-source it so its settings/functions are loaded
if (Test-Path $ProfileScript) {
  . $ProfileScript
}
