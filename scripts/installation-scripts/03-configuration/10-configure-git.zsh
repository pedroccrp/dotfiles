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

echo "Setting up delta diff tool..."

git config --global core.pager delta
git config --global interactive.diffFilter 'delta --color-only'
git config --global delta.line-numbers true
git config --global delta.side-by-side true
git config --global delta.navigate true
git config --global delta.dark true  # or `delta.light true`, or omit for auto-detection
git config --global merge.conflictStyle zdiff3

echo "Setting up smtp for git..."

git config --global sendemail.smtpserver smtp.gmail.com
git config --global sendemail.smtpuser pontescpedro@gmail.com
git config --global sendemail.smtpserverport 465
git config --global sendemail.smtpencryption ssl

echo "Done."
