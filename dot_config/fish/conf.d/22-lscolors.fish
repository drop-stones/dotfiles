# return if not interactive
if not status is-interactive
    return
end

# return if already initialized
if set -q __lscolors_initialized
    return
end

# generate and persist LS_COLORS
set -Ux LS_COLORS (vivid generate tokyonight-night)

# mark as initialized
set -U __lscolors_initialized true
