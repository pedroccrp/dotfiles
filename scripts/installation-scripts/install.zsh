#!/usr/bin/env zsh

set -euo pipefail

_usage() {
  cat <<'EOF'
dotfiles installer

Usage:
  install.zsh --target TARGET --profile PROFILE [options]

Required:
  --target   arch|ubuntu
  --profile  desktop|laptop|server|minimal

Options:
  --gpu                  nvidia|none (default: none)
  --yes                  assume yes where applicable
  --dry-run              print what would run
  --link                 create config symlinks (default: off)
  --no-link
  --with-asdf            run asdf plugin setup (default: off)
  --without-asdf
  --with-android         run android/sdk steps (default: off)
  --without-android
  --with-opencode        install opencode (default: off)
  --without-opencode
  --force                reserved for future use
  -h, --help             show this help

Examples:
  zsh scripts/installation-scripts/install.zsh --target arch --profile desktop --gpu nvidia --link --with-asdf --with-opencode
  zsh scripts/installation-scripts/install.zsh --target ubuntu --profile server --link

Notes:
  - This script does not auto-detect hardware or OS; pass explicit flags.
  - Arch flow reuses existing scripts under scripts/installation-scripts/.
  - Ubuntu flow delegates to scripts/ubuntu-server/.
EOF
}

_script_dir() {
  local d
  d=$(cd -P -- "$(dirname -- "$0")" && pwd)
  print -r -- "$d"
}

_say() { print -r -- "$*"; }
_die() { print -r -- "error: $*" >&2; exit 1; }

dry_run=false
assume_yes=false
do_link=false
force=false

target=""
profile=""
gpu="none"

with_android=false
with_opencode=false
with_asdf=false

while (( $# )); do
  case "$1" in
    -h|--help)
      _usage
      exit 0
      ;;
    --dry-run)
      dry_run=true
      ;;
    --yes)
      assume_yes=true
      ;;
    --target)
      shift
      target="${1:-}"
      ;;
    --profile)
      shift
      profile="${1:-}"
      ;;
    --gpu)
      shift
      gpu="${1:-}"
      ;;
    --with-android)
      with_android=true
      ;;
    --without-android)
      with_android=false
      ;;
    --with-opencode)
      with_opencode=true
      ;;
    --without-opencode)
      with_opencode=false
      ;;
    --with-asdf)
      with_asdf=true
      ;;
    --without-asdf)
      with_asdf=false
      ;;
    --link)
      do_link=true
      ;;
    --no-link)
      do_link=false
      ;;
    --force)
      force=true
      ;;
    *)
      _die "unknown argument: $1"
      ;;
  esac
  shift
done

[[ -n "$target" ]] || _die "missing --target (arch|ubuntu). Use --help."
[[ -n "$profile" ]] || _die "missing --profile (desktop|laptop|server|minimal). Use --help."

case "$target" in
  arch|ubuntu) ;;
  *) _die "invalid --target: $target" ;;
esac

case "$profile" in
  desktop|laptop|server|minimal) ;;
  *) _die "invalid --profile: $profile" ;;
esac

case "$gpu" in
  nvidia|none) ;;
  *) _die "invalid --gpu: $gpu" ;;
esac

SCRIPT_DIR=$(_script_dir)
DOTFILES_ROOT=${DOTFILES:-"$(cd "$SCRIPT_DIR/../.." && pwd)"}
export DOTFILES="$DOTFILES_ROOT"

_run_zsh() {
  local script="$1"
  shift || true

  [[ -f "$script" ]] || _die "missing script: $script"

  if $dry_run; then
    _say "> zsh $script ${*:-}"
    return 0
  fi
  zsh "$script" "$@"
}

_section() {
  _say ""
  _say "==> $*"
}

_section "Plan"
_say "==> dotfiles=$DOTFILES"
_say "==> target=$target profile=$profile gpu=$gpu"
_say "==> link=$do_link dry_run=$dry_run yes=$assume_yes asdf=$with_asdf android=$with_android opencode=$with_opencode force=$force"

if [[ "$target" == "ubuntu" ]]; then
  _section "Ubuntu/Debian"
  _run_zsh "$DOTFILES/scripts/ubuntu-server/00-prepare-shell.zsh"
  _run_zsh "$DOTFILES/scripts/ubuntu-server/10-install-required-packages.zsh"
  if $do_link; then
    _run_zsh "$DOTFILES/scripts/ubuntu-server/20-create-config-links.zsh"
  fi
  _say ""
  _say "Done."
  exit 0
fi

_section "Arch"
if [[ "$gpu" == "nvidia" ]]; then
  _run_zsh "$DOTFILES/scripts/installation-scripts/00-install-basic-packages.zsh"
fi

if [[ "$profile" == "desktop" || "$profile" == "laptop" ]]; then
  _run_zsh "$DOTFILES/scripts/installation-scripts/10-install-packages.zsh"
  _run_zsh "$DOTFILES/scripts/installation-scripts/11-install-community-packages.zsh"

  if $with_asdf; then
    _run_zsh "$DOTFILES/scripts/installation-scripts/12-install-asdf-packages.zsh"
  fi

  _run_zsh "$DOTFILES/scripts/installation-scripts/13-install-zsh-plugins.zsh"
else
  _say "Skipping workstation package/AUR/zsh-plugin scripts for profile '$profile'."
fi

_run_zsh "$DOTFILES/scripts/installation-scripts/30-prepare-git.zsh"

_run_zsh "$DOTFILES/scripts/installation-scripts/14-install-tmux-plugins.zsh"

if $with_android || $with_opencode; then
  _run_zsh "$DOTFILES/scripts/installation-scripts/15-install-dev-tools.zsh"
fi

if $do_link; then
  _run_zsh "$DOTFILES/scripts/installation-scripts/40-create-config-links.zsh"
fi

_run_zsh "$DOTFILES/scripts/installation-scripts/41-create-extra-folders.zsh"
_run_zsh "$DOTFILES/scripts/installation-scripts/42-sync-default-colors.zsh"

if [[ "$profile" == "desktop" || "$profile" == "laptop" ]]; then
  _run_zsh "$DOTFILES/scripts/installation-scripts/20-setup-system.zsh"
fi

_say ""
_say "Done."
