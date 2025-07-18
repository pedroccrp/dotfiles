echo "Logging into Bitwarden..."
bw login

echo "Logging into gh..."
gh auth login -p ssh -h GitHub.com

git config --global user.email "pontescpedro@gmail.com"
git config --global user.name "pedroccrp"
git config --global core.editor "nvim"
