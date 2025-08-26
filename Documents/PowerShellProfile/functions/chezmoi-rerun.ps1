# Define function with approved verb to avoid PSUseApprovedVerbs warning
function global:Invoke-ChezmoiRerun {
  try {
    chezmoi state reset --force
    chezmoi init
    chezmoi apply
  } catch {
    Write-Error "chezmoi-rerun failed: $_"
    return
  }
}

# Provide user-friendly alias so we can run `chezmoi-rerun` directly
Set-Alias -Name chezmoi-rerun -Value Invoke-ChezmoiRerun -Scope Global
