# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Zsh ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Git ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

git config --global alias.dsf "diff --color"
git config --global pager.dsf "diff-so-fancy | less --tabs=4 -RFXS"

# path=$(readlink $0)
# echo $path
