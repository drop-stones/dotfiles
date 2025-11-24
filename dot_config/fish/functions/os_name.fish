# Detect the current OS in a simplified, one-word format.
# Returns: linux | macos | wsl2 | msys2 | cygwin | unknown
#
# Implementation note:
# Normally, one might use `uname -s` or `uname -r` for OS detection.
# However, on MSYS2/WSL these external commands are relatively expensive
# (each call involves a slow process fork/exec).
# Since this function is called frequently from conf.d and other scripts,
# we rely on environment variables (MSYSTEM, CYGWIN, WSL_DISTRO_NAME, OSTYPE)
# that are already set by the runtime environment.
# This avoids repeated external command calls and keeps startup fast.
function os_name
    if set -q MSYSTEM
        echo msys2
        return
    end

    if set -q CYGWIN
        echo cygwin
        return
    end

    if set -q WSL_DISTRO_NAME
        echo wsl2
        return
    end

    if set -q OSTYPE
        switch $OSTYPE
            case 'linux*'
                echo linux
                return
        end
    end

    set -l kernel (uname -s)
    switch $kernel
        case Darwin
            echo macos
            return
    end

    echo unknown
end
