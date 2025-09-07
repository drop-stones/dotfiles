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

# except msys2
string match -q msys2 (os_name); and return

##############################################
# mise: The front-end to your dev env
##############################################

initcache source mise activate fish
