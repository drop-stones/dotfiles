if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
  # rustup shell setup
  # affix colons on either side of $PATH to simplify matching
  case ":${PATH}:" in
  *:"$HOME/.cargo/bin":*) ;;
  *)
    # Prepending path in case a system-installed rustc needs to be overridden
    path-add --prepend "$HOME/.cargo/bin"
    ;;
  esac
fi
