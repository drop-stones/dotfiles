# exit if not interactive
if not status is-interactive
    exit
end

# exit if already initialized
if set -q __tide_user_initialized
    exit
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

# set sentinel value
set -U __tide_user_initialized true
