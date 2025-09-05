# return if not interactive
if not status is-interactive
    return
end

# return if already initialized
if set -q __tokyonight_theme_initialized
    return
end

# Ensure theme are saved
fish_config theme choose tokyonight_night
yes | fish_config theme save

# mark as initialized
set -U __tokyonight_theme_initialized true
