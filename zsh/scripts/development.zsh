ng() {
  unfunction ng

  if ! asdf which ng >/dev/null 2>&1; then
    echo "Error: Angular CLI (ng) is not installed via asdf." >&2
    return 1
  fi

  if [[ -z ${functions[_ng]} ]]; then
    source <(command ng completion script)
  fi

  ng "$@"
}
