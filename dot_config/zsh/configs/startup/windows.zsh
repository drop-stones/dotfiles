if [[ -n "$MSYSTEM" ]]; then
  # complete hard drives in msys2
  drives=$(mount | sed -rn 's#^[A-Z]: on /([a-z]).*#\1#p' | tr '\n' ' ')
  zstyle ':completion:*' fake-files /: "/:$drives"
  unset drives
fi
