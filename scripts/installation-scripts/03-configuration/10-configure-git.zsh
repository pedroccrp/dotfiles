#!/usr/bin/env zsh

set -euo pipefail

if gh auth status --hostname github.com >/dev/null 2>&1; then
  echo "Already logged to gh!"
else
  echo "Logging into gh..."
  gh auth login -p ssh -h GitHub.com
fi

echo "Setting global configs for git..."

git config --global user.email "pontescpedro@gmail.com"
git config --global user.name "Pedro Pontes"
git config --global core.editor "nvim"

git config --global pull.rebase true

echo "Setting up smtp for git..."

git config --global sendemail.smtpserver smtp.gmail.com
git config --global sendemail.smtpuser pontescpedro@gmail.com
git config --global sendemail.smtpserverport 465
git config --global sendemail.smtpencryption ssl

echo "Done."
