#!/usr/bin/env zsh

set -euo pipefail

DOTFILES=${DOTFILES:-"$HOME/dotfiles"}
PROFILE_NAME="main"
PROFILE_PATH="$DOTFILES/zen"
ZEN_CONFIG_DIR="$HOME/.config/zen"
PROFILES_INI="$ZEN_CONFIG_DIR/profiles.ini"
INSTALLS_INI="$ZEN_CONFIG_DIR/installs.ini"

if ! command -v zen-browser >/dev/null 2>&1; then
  print -r -- "Skipping Zen profile setup: zen-browser not found."
  exit 0
fi

mkdir -p "$PROFILE_PATH/chrome"

if [[ -f "$PROFILES_INI" ]] && grep -Eq '^Name=main$' "$PROFILES_INI"; then
  if grep -Eq "^Path=$PROFILE_PATH$" "$PROFILES_INI"; then
    print -r -- "Zen profile 'main' already exists."
  else
    print -r -- "Zen profile 'main' already exists at a different path."
    exit 0
  fi
else
  zen-browser --CreateProfile "$PROFILE_NAME $PROFILE_PATH"
fi

if [[ ! -f "$PROFILES_INI" ]]; then
  print -r -- "Skipping Zen default profile setup: profiles.ini not found."
  exit 0
fi

changed_any=false

update_default_sections() {
  local file="$1"
  local mode="$2"
  local tmp
  local section=""
  local in_target=false
  local in_general=false
  local seen_default=false
  local seen_locked=false
  local seen_start_with_last=false
  local has_target=false
  local in_profile=false
  local profile_name=""
  local line=""

  [[ -f "$file" ]] || return 0

  tmp=$(mktemp)

  flush_section() {
    if $in_target; then
      if ! $seen_default; then
        print -r -- "Default=$PROFILE_PATH" >>"$tmp"
        changed_any=true
      fi
      if ! $seen_locked; then
        print -r -- "Locked=1" >>"$tmp"
        changed_any=true
      fi
    fi
    if [[ "$mode" == "profiles" ]] && $in_general && ! $seen_start_with_last; then
      print -r -- "StartWithLastProfile=1" >>"$tmp"
      changed_any=true
    fi
  }

  while IFS= read -r line || [[ -n "$line" ]]; do
    if [[ "$line" == \[*\] ]]; then
      flush_section

      section="${line:1:${#line}-2}"

      in_general=false
      in_profile=false
      profile_name=""
      if [[ "$mode" == "profiles" ]]; then
        if [[ "$section" == Install* ]]; then
          in_target=true
          has_target=true
        else
          in_target=false
        fi
        [[ "$section" == "General" ]] && in_general=true
        [[ "$section" == Profile* ]] && in_profile=true
      else
        in_target=true
        has_target=true
      fi

      seen_default=false
      seen_locked=false
      seen_start_with_last=false

      print -r -- "$line" >>"$tmp"
      continue
    fi

    if [[ "$mode" == "profiles" ]] && $in_profile && [[ "$line" == Name=* ]]; then
      profile_name="${line#Name=}"
      print -r -- "$line" >>"$tmp"
      continue
    fi

    if [[ "$mode" == "profiles" ]] && $in_profile && [[ "$line" == Default=1 ]] && [[ "$profile_name" != "$PROFILE_NAME" ]]; then
      changed_any=true
      continue
    fi

    if $in_target && [[ "$line" == Default=* ]]; then
      if [[ "$line" != "Default=$PROFILE_PATH" ]]; then
        changed_any=true
      fi
      print -r -- "Default=$PROFILE_PATH" >>"$tmp"
      seen_default=true
      continue
    fi

    if $in_target && [[ "$line" == Locked=* ]]; then
      if [[ "$line" != "Locked=1" ]]; then
        changed_any=true
      fi
      print -r -- "Locked=1" >>"$tmp"
      seen_locked=true
      continue
    fi

    if [[ "$mode" == "profiles" ]] && $in_general && [[ "$line" == StartWithLastProfile=* ]]; then
      if [[ "$line" != "StartWithLastProfile=1" ]]; then
        changed_any=true
      fi
      print -r -- "StartWithLastProfile=1" >>"$tmp"
      seen_start_with_last=true
      continue
    fi

    print -r -- "$line" >>"$tmp"
  done <"$file"

  flush_section

  if [[ "$mode" == "profiles" ]] && ! $has_target; then
    print -r -- "No Install section found in profiles.ini; cannot set install default there."
  fi

  mv "$tmp" "$file"
}

update_default_sections "$PROFILES_INI" "profiles"
update_default_sections "$INSTALLS_INI" "installs"

if $changed_any; then
  print -r -- "Zen profile 'main' set as default."
else
  print -r -- "main is already default"
fi
