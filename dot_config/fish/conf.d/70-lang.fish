##############################################
#  Rust
##############################################

# Add Cargo bin to PATH only on Linux and macOS.
# Windows installers typically add it already.
# Respect CARGO_HOME if set; fallback to ~/.cargo
switch (os_name)
    case linux wsl2 macos
        set -l cargo_bin $HOME/.cargo/bin
        if test -d "$cargo_bin"
            fish_add_path -g --prepend "$cargo_bin"
        end
end
