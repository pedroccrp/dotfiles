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

  local cmd_status=${pipestatus[1]:-0}

  for _ in $(seq 1 $((LOG_LINES + HEADER_LINES + 1))); do
    tput cuu 1
    printf '\r'
    tput el
  done

  _record_update_result "$title" "$cmd_status"

  if ((cmd_status == 0)); then
    printf "%s==> %s [completed]%s\n" "$BOLD" "$title" "$RESET"
  else
    printf "%s==> %s [failed]%s\n" "$BOLD" "$title" "$RESET"
  fi

  return "$cmd_status"
}

typeset -ga UPDATE_STEP_TITLES=()
typeset -ga UPDATE_STEP_CODES=()

_reset_update_results() {
  UPDATE_STEP_TITLES=()
  UPDATE_STEP_CODES=()
}

_record_update_result() {
  local title="$1"
  local code="$2"

  UPDATE_STEP_TITLES+=("$title")
  UPDATE_STEP_CODES+=("$code")
}

_run_update_step() {
  local title="$1"
  shift

  "$@"
  local step_code=$?

  _record_update_result "$title" "$step_code"
  return "$step_code"
}

_print_update_results() {
  local BOLD RESET GREEN RED

  if [[ -t 1 ]]; then
    BOLD=$(tput bold)
    RESET=$(tput sgr0)
    GREEN=$(tput setaf 2)
    RED=$(tput setaf 1)
  else
    BOLD=""
    RESET=""
    GREEN=""
    RED=""
  fi

  local total=${#UPDATE_STEP_TITLES[@]}
  local succeeded=0
  local failed=0

  echo
  printf "%s==> Results%s\n" "$BOLD" "$RESET"
  echo "-----------------------------------------------"

  local i code status_label
  for ((i = 1; i <= total; i++)); do
    code=${UPDATE_STEP_CODES[i]}
    if ((code == 0)); then
      status_label="${GREEN}OK${RESET}"
      ((succeeded++))
    else
      status_label="${RED}FAIL (${code})${RESET}"
      ((failed++))
    fi

    printf "- [%s] %s\n" "$status_label" "${UPDATE_STEP_TITLES[i]}"
  done

  echo "-----------------------------------------------"
  printf "Succeeded: %d | Failed: %d | Total: %d\n" "$succeeded" "$failed" "$total"
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

  local step_failed=0

  _update_packages_ui \
    "Fetching dotfiles updates" \
    git pull || step_failed=1

  _update_packages_ui \
    "Syncing git submodules" \
    zsh "$DOTFILES/scripts/installation-scripts/03-configuration/15-sync-submodules.zsh" || step_failed=1

  cd - >/dev/null
  return "$step_failed"
}

run_installation_scripts() {
  local profile="$1"
  local gpu="$2"
  local with_heavy_aur="$3"
  local with_asdf="$4"
  local do_link="$5"
  local step_failed=0

  if ((EUID != 0)); then
    sudo -v || return 1
  fi

  _update_packages_ui \
    "Ensuring yay is installed" \
    zsh "$DOTFILES/scripts/installation-scripts/01-system/00-install-yay.zsh" || step_failed=1

  _update_packages_ui \
    "Installing core packages" \
    zsh "$DOTFILES/scripts/installation-scripts/01-system/10-install-core.zsh" "$gpu" || step_failed=1

  if [[ "$profile" == "desktop" || "$profile" == "laptop" ]]; then
    _update_packages_ui \
      "Installing desktop packages" \
      zsh "$DOTFILES/scripts/installation-scripts/01-system/20-install-desktop.zsh" || step_failed=1

    if [[ "$with_heavy_aur" == "true" ]]; then
      _update_packages_ui \
        "Installing AUR packages (with heavy)" \
        zsh "$DOTFILES/scripts/installation-scripts/02-packages/10-install-aur.zsh" --with-heavy || step_failed=1
    else
      _update_packages_ui \
        "Installing AUR packages" \
        zsh "$DOTFILES/scripts/installation-scripts/02-packages/10-install-aur.zsh" || step_failed=1
    fi

    if [[ "$with_asdf" == "true" ]]; then
      _update_packages_ui \
        "Configuring asdf plugins" \
        zsh "$DOTFILES/scripts/installation-scripts/02-packages/20-install-asdf-plugins.zsh" || step_failed=1
    fi

    _update_packages_ui \
      "Installing shell plugins" \
      zsh "$DOTFILES/scripts/installation-scripts/02-packages/30-install-shell-plugins.zsh" || step_failed=1
  fi

  if [[ "$do_link" == "true" ]]; then
    _update_packages_ui \
      "Refreshing config symlinks" \
      zsh "$DOTFILES/scripts/installation-scripts/03-configuration/30-create-symlinks.zsh" || step_failed=1
  fi

  _update_packages_ui \
    "Creating extra folders" \
    zsh "$DOTFILES/scripts/installation-scripts/03-configuration/35-create-extra-folders.zsh" || step_failed=1

  _update_packages_ui \
    "Configuring shell completions" \
    zsh "$DOTFILES/scripts/installation-scripts/03-configuration/40-configure-completions.zsh" || step_failed=1

  _update_packages_ui \
    "Syncing default colors" \
    zsh "$DOTFILES/scripts/installation-scripts/04-theming/10-sync-colors.zsh" || step_failed=1

  return "$step_failed"
}

update_pacman_packages() {
  sudo pacman -Syu --noconfirm --noprogressbar
}

timeshift_backup() {
  if ! command -v timeshift >/dev/null 2>&1; then
    echo "Skipping timeshift: timeshift is not installed."
    return 0
  fi

  sudo timeshift --create --comments "system update" --tags D
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
  local with_timeshift="false"
  local do_link="true"
  local update_failed=0

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
      --with-timeshift)
        with_timeshift="true"
        ;;
      --no-link)
        do_link="false"
        ;;
      *)
        echo "Unknown option: $1"
        echo "Usage: update_system [--profile desktop|laptop|server|minimal] [--gpu nvidia|none] [--with-heavy-aur] [--with-asdf] [--with-aur-updates] [--with-timeshift] [--no-link]"
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
  _reset_update_results

  trap 'kill "$SUDO_KEEPALIVE_PID" 2>/dev/null' EXIT

  if [[ "$with_timeshift" == "true" ]]; then
    _run_update_step "Creating timeshift backup" timeshift_backup || update_failed=1
  fi

  update_config_files || update_failed=1
  _run_update_step "Updating pacman packages" update_pacman_packages || update_failed=1
  if [[ "$with_aur_updates" == "true" ]]; then
    _run_update_step "Updating AUR packages" update_yay_packages || update_failed=1
  fi
  _run_update_step "Initializing completions" compinit || update_failed=1
  run_installation_scripts "$profile" "$gpu" "$with_heavy_aur" "$with_asdf" "$do_link" || update_failed=1

  _print_update_results

  if ((update_failed != 0)); then
    echo "System update completed with failures."
    return 1
  fi

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
