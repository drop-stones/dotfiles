# Remove bg highlight
FZF_DEFAULT_OPTS=$(echo $FZF_DEFAULT_OPTS | sed -e 's/--color=bg:#[^[:space:]]\+//')
