# Do nothing if not msys2
is-msys2 || return 0

# complete hard drives in msys2
drives=$(mount | sed -rn 's#^[A-Z]: on /([a-z]).*#\1#p' | tr '\n' ' ')
zstyle ':completion:*' fake-files /: "/:$drives"
unset drives
