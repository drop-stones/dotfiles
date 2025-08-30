# Customized fish_clipboard_paste
# Original: https://github.com/fish-shell/fish-shell/blob/master/share/functions/fish_clipboard_paste.fish
# Change: Added win32yank.exe support and prioritized it over powershell.exe on Windows
function fish_clipboard_paste
    set -l data
    if type -q win32yank.exe # windows
        set data (win32yank.exe -o 2>/dev/null | string trim -r -c \r | string collect -N)
    else if type -q powershell.exe
        set data (powershell.exe Get-Clipboard | string trim -r -c \r | string collect -N)
    else if type -q pbpaste # macos
        set data (pbpaste 2>/dev/null | string collect -N)
    else if set -q WAYLAND_DISPLAY; and type -q wl-paste
        set data (wl-paste -n 2>/dev/null | string collect -N) # wayland
    else if set -q DISPLAY; and type -q xsel
        set data (xsel --clipboard | string collect -N)
    else if set -q DISPLAY; and type -q xclip
        set data (xclip -selection clipboard -o 2>/dev/null | string collect -N)
    end

    # Issue 6254: Handle zero-length clipboard content
    if not string length -q -- "$data"
        return 1
    end

    if not isatty stdout
        # If we're redirected, just write the data *as-is*.
        printf %s $data
        return
    end

    __fish_paste $data
end
