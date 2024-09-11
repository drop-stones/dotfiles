if [[ "$OSTYPE" == "msys" ]]; then
  return
fi

_evalcache batman --export-env
