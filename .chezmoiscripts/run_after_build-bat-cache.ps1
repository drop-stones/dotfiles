# Rebuild the bat theme cache on every apply: the theme arrives as a chezmoi
# external, which never triggers run_onchange scripts. This mirrors
# home-manager, which also rebuilds the cache on every activation.
bat cache --build
