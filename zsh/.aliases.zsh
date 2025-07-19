alias reload="source $HOME/.zshrc"

alias la="ls -lAh"

alias pbcopy="xclip -selection clipboard"
alias pbpaste="xclip -selection clipboard -o"

alias vim=nvim

alias gfa="git fetch --all --prune --prune-tags --tags"
alias gco="git checkout"
alias gcb='git checkout -b'
alias gcB='git checkout -B'
alias gcp="git cherry-pick"
alias gap="git add -p"
alias gcm="git commit"
alias gpp="git push origin HEAD"

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Methods ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

best_release() {
  grep -F -x -v -f <(git log "$1" --pretty=format:"%s" | sed 's/ (#[0-9]*)//g') <(git log "$2" --pretty=format:"%s" | sed 's/ (#[0-9]*)//g') | uniq | grep -e DPMS -e DUV -e SDPMS
}

best_release_hash() {
  git log "$2" --pretty=format:"%H - %s" | grep -f <(best_release "$1" "$2")
}

fif() {
  if [ ! "$#" -gt 0 ]; then echo "Need a string to search for!"; return 1; fi
  rg --files-with-matches --no-messages "$1" | fzf -m --preview "highlight -O ansi -l {} 2> /dev/null | rg --colors 'match:bg:yellow' --ignore-case --pretty --context 10 '$1' || rg --ignore-case --pretty --context 10 '$1' {}"
}

lowercase_user_folders() {
  cd ~

  sed -ri 's/[a-zA-Z]+\"/\L&/g' .config/user-dirs.dirs

  folders=( "Desktop" "Documents" "Downloads" "Music" "Pictures" "Public" "Templates" "Videos" )
  for i in "${folders[@]}"
  do
    mv $i $(echo $i | tr '[:upper:]' '[:lower:]') &> /dev/null
  done
}

j() {
    local preview_cmd="ls {2..}"
    if command -v exa &> /dev/null; then
        preview_cmd="exa -l {2}"
    fi

    if [[ $# -eq 0 ]]; then
                 cd "$(autojump -s | sort -k1gr | awk -F : '$1 ~ /[0-9]/ && $2 ~ /^\s*\// {print $1 $2}' | fzf --height 40% --reverse --inline-info --preview "$preview_cmd" --preview-window down:50% | cut -d$'\t' -f2- | sed 's/^\s*//')"
    else
        cd $(autojump $@)
    fi
}

optimize_mysql_tables() {
  local container_name="$1"
  local mysql_password="$2"

  if [[ -z "$container_name" || -z "$mysql_password" ]]; then
    echo "Usage: optimize_mysql_tables <container_name> <mysql_password>"
    return 1
  fi

  for table in $(docker exec -it "$container_name" mysql -uroot -p"$mysql_password" -sss -e "SELECT CONCAT(table_schema, '.', table_name) FROM information_schema.tables WHERE table_schema NOT IN ('mysql', 'information_schema', 'performance_schema') AND TABLE_TYPE='BASE TABLE' ORDER BY data_free DESC;"); do
    echo "Optimizing table: $table"
    docker exec -it "$container_name" mysql -uroot -p"$mysql_password" -sss -e "OPTIMIZE TABLE $table;"
  done

  echo "All tables optimized!"
}
