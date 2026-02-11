# return if not interactive
if not status is-interactive
    return
end

##############################################
#  Vi mode
##############################################

fish_vi_key_bindings

##############################################
# zoxide: A smarter cd command
##############################################

initcache source zoxide init fish
