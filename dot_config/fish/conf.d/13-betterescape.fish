# return if not interactive
if not status is-interactive
    return
end

set -g betterescape_sequence jk
set -g betterescape_timeout 150 # ms
