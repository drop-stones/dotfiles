# return if not interactive
if not status is-interactive
    return
end

# key bindings
fzf_configure_bindings \
    --history=\cr \
    --directory= \
    --git_log= \
    --git_status= \
    --processes= \
    --variables=
