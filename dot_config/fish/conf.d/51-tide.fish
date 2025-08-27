# return if not interactive
if not status is-interactive
    return
end

# return if already initialized
if set -q __tide_user_initialized
    return
end

# initialization
tide configure --auto \
    --style=Lean \
    --prompt_colors='True color' \
    --show_time=No \
    --lean_prompt_height='Two lines' \
    --prompt_connection=Disconnected \
    --prompt_spacing=Sparse \
    --icons='Few icons' \
    --transient=Yes

# mark as initialized
set -U __tide_user_initialized true
