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
- `--with-ruby-lsp` / `--without-ruby-lsp`
- `--with-heavy-aur` / `--without-heavy-aur`
- `--dry-run`

## What Each Script Does

Arch scripts (`scripts/installation-scripts/`):

- `01-system/00-install-yay.zsh`: install `yay`
- `01-system/10-install-core.zsh`: core packages (`neovim` and optional NVIDIA bits)
- `01-system/20-install-desktop.zsh`: main pacman package sets for workstation profiles
- `02-packages/10-install-aur.zsh`: AUR packages (light by default, heavy with `--with-heavy`)
- `02-packages/20-install-asdf-plugins.zsh`: add asdf plugins and set them to `system`
- `02-packages/30-install-shell-plugins.zsh`: install zsh plugin packages
- `03-configuration/10-configure-git.zsh`: `gh auth login` + global git config (personal)
- `03-configuration/20-configure-services.zsh`: services and defaults (bluetooth/docker/ly/ufw)
- `03-configuration/30-create-symlinks.zsh`: symlink dotfiles into `$HOME` / `$HOME/.config`
- `03-configuration/35-create-extra-folders.zsh`: create extra folders
- `03-configuration/40-configure-completions.zsh`: generate docker zsh completion
- `04-theming/10-sync-colors.zsh`: populate default color cache files (idempotent)
- `04-theming/20-configure-pacman-hooks.zsh`: link pacman hooks from dotfiles
- `05-optional/10-install-dev-tools.zsh`: optional dev tools (`--with-android`, `--with-ruby-lsp`, `--with-opencode`)

Ubuntu scripts (`scripts/ubuntu-server/`):

- `00-prepare-shell.zsh`: install zsh and set it as the login shell
- `10-install-required-packages.zsh`: apt packages for CLI/dev basics
- `20-create-config-links.zsh`: symlink dotfiles into `$HOME` / `$HOME/.config`

## Safety Notes

- `03-configuration/30-create-symlinks.zsh` removes existing paths before linking; expect it to overwrite local state.
- `03-configuration/20-configure-services.zsh` enables UFW with default deny and enables a display manager service on tty2; be careful when running on remote machines.
