if [[ -n "$MSYSTEM" ]]; then
  return
fi

_evalcache batman --export-env
