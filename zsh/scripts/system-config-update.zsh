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
  local profile="$1"
  local gpu="$2"
  local with_heavy_aur="$3"
  local with_asdf="$4"
  local do_link="$5"

  if ((EUID != 0)); then
    sudo -v || return 1
  fi

  _update_packages_ui \
    "Ensuring yay is installed" \
    zsh "$DOTFILES/scripts/installation-scripts/01-system/00-install-yay.zsh"

  _update_packages_ui \
    "Installing core packages" \
    zsh "$DOTFILES/scripts/installation-scripts/01-system/10-install-core.zsh" "$gpu"

  if [[ "$profile" == "desktop" || "$profile" == "laptop" ]]; then
    _update_packages_ui \
      "Installing desktop packages" \
      zsh "$DOTFILES/scripts/installation-scripts/01-system/20-install-desktop.zsh"

    if [[ "$with_heavy_aur" == "true" ]]; then
      _update_packages_ui \
        "Installing AUR packages (with heavy)" \
        zsh "$DOTFILES/scripts/installation-scripts/02-packages/10-install-aur.zsh" --with-heavy
    else
      _update_packages_ui \
        "Installing AUR packages" \
        zsh "$DOTFILES/scripts/installation-scripts/02-packages/10-install-aur.zsh"
    fi

    if [[ "$with_asdf" == "true" ]]; then
      _update_packages_ui \
        "Configuring asdf plugins" \
        zsh "$DOTFILES/scripts/installation-scripts/02-packages/20-install-asdf-plugins.zsh"
    fi

    _update_packages_ui \
      "Installing shell plugins" \
      zsh "$DOTFILES/scripts/installation-scripts/02-packages/30-install-shell-plugins.zsh"
  fi

  if [[ "$do_link" == "true" ]]; then
    _update_packages_ui \
      "Refreshing config symlinks" \
      zsh "$DOTFILES/scripts/installation-scripts/03-configuration/30-create-symlinks.zsh"
  fi

  _update_packages_ui \
    "Creating extra folders" \
    zsh "$DOTFILES/scripts/installation-scripts/03-configuration/35-create-extra-folders.zsh"

  _update_packages_ui \
    "Configuring shell completions" \
    zsh "$DOTFILES/scripts/installation-scripts/03-configuration/40-configure-completions.zsh"

  _update_packages_ui \
    "Syncing default colors" \
    zsh "$DOTFILES/scripts/installation-scripts/04-theming/10-sync-colors.zsh"

  if [[ "$profile" == "desktop" || "$profile" == "laptop" ]]; then
    _update_packages_ui \
      "Configuring pacman hooks" \
      zsh "$DOTFILES/scripts/installation-scripts/04-theming/20-configure-pacman-hooks.zsh"
  fi
}

update_pacman_packages() {
  sudo pacman -Syu --noconfirm --noprogressbar
}

update_yay_packages() {
  if ! command -v yay >/dev/null 2>&1; then
    echo "Skipping yay updates: yay is not installed."
    return 0
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
  local profile="desktop"
  local gpu="none"
  local with_heavy_aur="false"
  local with_asdf="false"
  local with_aur_updates="false"
  local do_link="true"

  while (( $# )); do
    case "$1" in
      --profile)
        shift
        profile="${1:-}"
        ;;
      --gpu)
        shift
        gpu="${1:-}"
        ;;
      --with-heavy-aur)
        with_heavy_aur="true"
        ;;
      --with-asdf)
        with_asdf="true"
        ;;
      --with-aur-updates)
        with_aur_updates="true"
        ;;
      --no-link)
        do_link="false"
        ;;
      *)
        echo "Unknown option: $1"
        echo "Usage: update_system [--profile desktop|laptop|server|minimal] [--gpu nvidia|none] [--with-heavy-aur] [--with-asdf] [--with-aur-updates] [--no-link]"
        return 1
        ;;
    esac
    shift
  done

  case "$profile" in
    desktop|laptop|server|minimal) ;;
    *)
      echo "Invalid --profile: $profile"
      return 1
      ;;
  esac

  case "$gpu" in
    nvidia|none) ;;
    *)
      echo "Invalid --gpu: $gpu"
      return 1
      ;;
  esac

  _start_sudo_keepalive || return 1

  trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT

  update_config_files || return
  update_pacman_packages || return
  [[ "$with_aur_updates" == "true" ]] && update_yay_packages
  compinit || return
  run_installation_scripts "$profile" "$gpu" "$with_heavy_aur" "$with_asdf" "$do_link" || return

  echo "System update completed successfully."
}

update_system_full() {
  update_system \
    --profile desktop \
    --gpu nvidia \
    --with-heavy-aur \
    --with-asdf \
    "$@"
}
