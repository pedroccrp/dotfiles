best_release() {
  grep -F -x -v -f <(git log "$1" --pretty=format:"%s" | sed 's/ (#[0-9]*)//g') <(git log "$2" --pretty=format:"%s" | sed 's/ (#[0-9]*)//g') | uniq | grep -e DPMS -e DUV -e SDPMS
}

best_release_hash() {
  git log "$2" --pretty=format:"%H - %s" | grep -f <(best_release "$1" "$2")
}
