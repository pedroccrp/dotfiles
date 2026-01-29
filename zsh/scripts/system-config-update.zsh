_update_packages_ui() {
  [[ -t 1 ]] || return 1

  local LOG_LINES=5
  local HEADER_LINES=2
  local buffer=()

  local BOLD DIM RESET
  BOLD=$(tput bold)
  DIM=$(tput dim)
  RESET=$(tput sgr0)

  local title="$1"
  shift
  local cmd=("$@")

  _print_header() {
    tput cuu $((LOG_LINES + HEADER_LINES + 1))
    printf '\r'
    tput el
    printf "%s==> %s%s\n" \
      "$BOLD" "$title" "$RESET"
    printf '\r'
    tput el
    echo "-----------------------------------------------"
  }

  _preprint_lines() {
    printf "%s==> %s%s\n" "$BOLD" "$title" "$RESET"
    echo "-----------------------------------------------"

    for _ in $(seq 0 $LOG_LINES); do
      echo
    done
  }

  _preprint_lines

  stdbuf -oL -eL "${cmd[@]}" 2>&1 | while IFS= read -r line; do
    buffer+=("$line")
    ((${#buffer[@]} > LOG_LINES)) && buffer=("${buffer[@]:1}")

    _print_header

    for l in "${buffer[@]}"; do
      printf '\r'
      tput el
      printf "%s%s%s\n" "$DIM" "$l" "$RESET"
    done

    for _ in $(seq ${#buffer[@]} $LOG_LINES); do
      printf '\r'
      tput el
      echo
    done
  done

  for _ in $(seq 1 $((LOG_LINES + HEADER_LINES + 1))); do
    tput cuu 1
    printf '\r'
    tput el
  done

  printf "%s==> %s [completed]%s\n" "$BOLD" "$title" "$RESET"
}

_start_sudo_keepalive() {
  if [[ -n "${SUDO_KEEPALIVE_PID-}" ]] && kill -0 "$SUDO_KEEPALIVE_PID" 2>/dev/null; then
    return 0
  fi

  sudo -v || return 1

  (
    while true; do
      sleep 30
      sudo -v || exit 0
    done
  ) &

  SUDO_KEEPALIVE_PID=$!
  export SUDO_KEEPALIVE_PID
}

update_config_files() {
  cd $DOTFILES || return 1

  _update_packages_ui \
    "Fetching dotfiles updates" \
    git pull

  cd - >/dev/null
}

run_installation_scripts() {
  if ((EUID != 0)); then
    sudo -v || return 1
  fi

  _update_packages_ui \
    "Running pacman installation script" \
    zsh "$DOTFILES/scripts/installation-scripts/10-install-packages.zsh"

  _update_packages_ui \
    "Running yay installation script" \
    zsh "$DOTFILES/scripts/installation-scripts/11-install-community-packages.zsh"

  _update_packages_ui \
    "Running zsh plugins installation script" \
    zsh "$DOTFILES/scripts/installation-scripts/13-install-zsh-plugins.zsh"

  _update_packages_ui \
    "Running tmux plugins installation script" \
    zsh "$DOTFILES/scripts/installation-scripts/14-install-tmux-plugins.zsh"

  _update_packages_ui \
    "Running config links creation script" \
    zsh "$DOTFILES/scripts/installation-scripts/40-create-config-links.zsh"
}

update_pacman_packages() {
  sudo pacman -Syu --noconfirm --noprogressbar
}

update_yay_packages() {
  if [[ -t 1 ]]; then
    printf "The AUR update via yay can take a long time. Proceed? [y/N] "
    read -r answer
    case "$answer" in
    [Yy]*) ;;
    *)
      echo "Skipping yay updates."
      return 0
      ;;
    esac
  fi

  yay -Sua \
    --noconfirm \
    --noprogressbar \
    --batchinstall \
    --ignore gcc14 \
    --ignore gcc14-libs \
    --ignore gcc14-fortran
}

update_system() {
  _start_sudo_keepalive || return 1

  trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT

  update_config_files || return
  run_installation_scripts || return
  update_pacman_packages || return
  update_yay_packages

  echo "System update completed successfully."
}
