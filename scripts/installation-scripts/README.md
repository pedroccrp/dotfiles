# Installation Scripts

This folder contains a personal dotfiles installer and the smaller scripts it calls.

## Quick Start

Arch workstation (Hyprland, apps, AUR, etc.):

```sh
zsh scripts/installation-scripts/install.zsh \
  --target arch \
  --profile desktop \
  --gpu none \
  --link \
  --with-asdf \
  --with-opencode
```

Arch workstation + NVIDIA drivers:

```sh
zsh scripts/installation-scripts/install.zsh \
  --target arch \
  --profile desktop \
  --gpu nvidia \
  --link \
  --with-asdf \
  --with-opencode
```

Ubuntu server:

```sh
zsh scripts/installation-scripts/install.zsh \
  --target ubuntu \
  --profile server \
  --link
```

Dry run:

```sh
zsh scripts/installation-scripts/install.zsh --dry-run --target arch --profile desktop --gpu none
```

## Shell Convenience

Zsh wrapper + completion are provided:

- Wrapper function: `dotfiles-install ...` (loaded by `zsh/scripts/dotfiles-install.zsh`)
- Completion: `zsh/completions/_dotfiles-install`

If completion does not show up in an existing terminal session:

```sh
exec zsh
```

## Installer Flags

`install.zsh` requires explicit choices (no auto-detection).

- `--target` `arch|ubuntu`
- `--profile` `desktop|laptop|server|minimal`
- `--gpu` `nvidia|none`
- `--link` / `--no-link` (default is `--no-link`)
- `--with-asdf` / `--without-asdf`
- `--with-android` / `--without-android`
- `--with-opencode` / `--without-opencode`
- `--dry-run`

## What Each Script Does

Arch scripts (`scripts/installation-scripts/`):

- `00-install-basic-packages.zsh`: basic packages (currently also installs NVIDIA dkms + headers)
- `10-install-packages.zsh`: main pacman packages for desktop setup (Hyprland, tools, fonts, etc.)
- `11-install-community-packages.zsh`: install `yay` and AUR packages
- `12-install-asdf-packages.zsh`: add asdf plugins and set them to `system`
- `13-install-zsh-plugins.zsh`: install zsh plugin packages
- `14-install-tmux-plugins.zsh`: install TPM and tmux plugins
- `15-install-dev-tools.zsh`: extra dev tools (Android sdkmanager, ruby-lsp, opencode)
- `20-setup-system.zsh`: system services and defaults (bluetooth/docker/ly/ufw)
- `30-prepare-git.zsh`: `gh auth login` + global git config (personal)
- `40-create-config-links.zsh`: symlink dotfiles into `$HOME` / `$HOME/.config`
- `41-create-extra-folders.zsh`: create extra folders and docker completion
- `42-sync-default-colors.zsh`: populate default color cache files (idempotent)

Ubuntu scripts (`scripts/ubuntu-server/`):

- `00-prepare-shell.zsh`: install zsh and set it as the login shell
- `10-install-required-packages.zsh`: apt packages for CLI/dev basics
- `20-create-config-links.zsh`: symlink dotfiles into `$HOME` / `$HOME/.config`

## Safety Notes

- `40-create-config-links.zsh` currently removes some existing config dirs before linking; expect it to overwrite local state.
- `20-setup-system.zsh` enables UFW with default deny and enables a display manager service on tty2; be careful when running on remote machines.
