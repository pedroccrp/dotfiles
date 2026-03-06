#!/usr/bin/env zsh

set -euo pipefail

install_android=false
install_ruby_lsp=false
install_opencode=false

while (( $# )); do
  case "$1" in
    --with-android)
      install_android=true
      ;;
    --with-ruby-lsp)
      install_ruby_lsp=true
      ;;
    --with-opencode)
      install_opencode=true
      ;;
    -y|--yes)
      install_android=true
      install_ruby_lsp=true
      install_opencode=true
      ;;
    *)
      echo "Unknown option: $1"
      echo "Usage: $0 [--with-android] [--with-ruby-lsp] [--with-opencode] [-y]"
      exit 1
      ;;
  esac
  shift
done

if $install_android; then
  sudo chown -R $USER:$USER /opt/android-sdk
  sdkmanager --install "build-tools;36.0.0"
  sdkmanager --install "platforms;android-36"
  sdkmanager --install "sources;android-36"
fi

if $install_ruby_lsp; then
  gem install ruby-lsp
fi

if $install_opencode; then
  curl -fsSL https://opencode.ai/install | bash
fi
