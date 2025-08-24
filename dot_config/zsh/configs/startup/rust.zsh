# Add Cargo bin to PATH only on Linux and macOS.
# Windows installers typically add it already.
# Respect CARGO_HOME if set; fallback to ~/.cargo

if is-linux || is-macos; then
  local cargo_bin="${CARGO_HOME:-$HOME/.cargo}/bin"
  [[ -d $cargo_bin ]] && path-add --prepend "$cargo_bin"
fi
