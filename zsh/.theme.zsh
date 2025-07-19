source /usr/lib/spaceship-prompt/spaceship.zsh

SPACESHIP_PROMPT_ORDER=(
  dir            # Current directory section
  user           # Username section
  host           # Hostname section
  git            # Git section (git_branch + git_status)
  package        # Package version
  node           # Node.js section
  bun            # Bun section
  ruby           # Ruby section
  python         # Python section
  kotlin         # Kotlin section
  java           # Java section
  lua            # Lua section
  dart           # Dart section
  docker         # Docker section
  docker_compose # Docker section
  kubectl        # Kubectl context section
  exec_time      # Execution time
  async          # Async jobs indicator
  line_sep       # Line break
  battery        # Battery level and status
  jobs           # Background jobs indicator
  exit_code      # Exit code section
  sudo           # Sudo indicator
  char           # Prompt character
)

SPACESHIP_PROMPT_ADD_NEWLINE=true
SPACESHIP_CHAR_SYMBOL="❯"
SPACESHIP_CHAR_SUFFIX=""
