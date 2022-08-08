# Adds a plugin.

# Get OS X Software Updates, and update installed Ruby gems, Homebrew, npm, and their installed packages
function update() {
  brew update && brew outdated && brew upgrade && brew cleanup
  sudo gem update --system && sudo gem update && gem cleanup all
  pip install --upgrade pip
  pip list -o --format columns | cut -d' ' -f1 | xargs -n1 pip install -U
  npm update npm -g
  npm update -g
  sudo softwareupdate -i -a
}

# Encode images in Base64
encodeBase64() {
  uuencode -m $1 /dev/stdout | sed '1d' | sed '$d'
}

# Create a data URL from a file
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Server
server() {
  browser-sync start --server --files "**"
}

# Determine size of a file or total size of a directory
fs() {
  if du -b /dev/null >/dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Manually remove a downloaded app or file from the quarantine
unquarantine() {
  for attribute in com.apple.metadata:kMDItemDownloadedDate com.apple.metadata:kMDItemWhereFroms com.apple.quarantine; do
    xattr -r -d "$attribute" "$@"
  done
}

# Auto change the nvm version based on a .nvmrc file based on the current directory.
# See https://github.com/creationix/nvm/issues/110#issuecomment-190125863
autoload -U add-zsh-hook
load-nvmrc() {
  if [[ -f .nvmrc && -r .nvmrc ]]; then
    nvm use
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf-tmux --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<<"$out")
  file=$(head -2 <<<"$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}

# fdr - cd to selected parent directory
fdr() {
  local declare dirs=()
  get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }

  local DIR=$(get_parent_dirs $(realpath "${1:-$(pwd)}") | fzf-tmux --tac)
  cd "$DIR"
}

# Find in files with ripgrep and fzf and open on that line
# -> Works together with Vim Plugin bogado/file-line
frg() {
  file=$(rg . --line-number | fzf | cut -d: -f1 -f2)
  if [ "$file" != "" ]; then
    nvim $file
  fi
}

# fkill - kill process
fkill() {
  pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

  if [ "x$pid" != "x" ]; then
    kill -${1:-9} $pid
  fi
}

# fco - checkout git branch/tag
fco() {
  local tags branches target
  tags=$(
    git tag | awk '{print "\x1b[31;1mtag\x1b[m\t" $1}'
  ) || return
  branches=$(
    git branch --all | grep -v HEAD |
      sed "s/.* //" | sed "s#remotes/[^/]*/##" |
      sort -u | awk '{print "\x1b[34;1mbranch\x1b[m\t" $1}'
  ) || return
  target=$(
    (
      echo "$tags"
      echo "$branches"
    ) |
      fzf-tmux -- --no-hscroll --ansi +m -d "\t" -n 2
  ) || return
  git checkout $(echo "$target" | awk '{print $2}')
}

# fcoc - checkout git commit
fcoc() {
  local commits commit
  commits=$(git log --pretty=oneline --abbrev-commit --reverse) &&
    commit=$(echo "$commits" | fzf --tac +s +m -e) &&
    git checkout $(echo "$commit" | sed "s/ .*//")
}

# fshow - git commit browser
fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
      (grep -o '[a-f0-9]\{7\}' | head -1 |
      xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
      {}
      FZF-EOF"
}

# Search z history with fzf
fz() {
  [ $# -gt 0 ] && _z "$*" && return
  cd "$(_z -l 2>&1 | fzf --height 40% --nth 2.. --reverse --inline-info +s --tac --query "${*##-* }" | sed 's/^[0-9,.]* *//')"
}

# Browse Brave history
fbh() {
  local cols sep
  cols=$((COLUMNS / 3))
  sep='{{::}}'

  # Copy History DB to circumvent the lock
  # See http://stackoverflow.com/questions/8936878 for the file path
  cp -f ~/Library/Application\ Support/BraveSoftware/Brave-Browser/Default/History /tmp/h

  sqlite3 -separator $sep /tmp/h \
    "select substr(title, 1, $cols), url
    from urls order by last_visit_time desc" |
    awk -F $sep '{printf "%-'$cols's  \x1b[36m%s\n", $1, $2}' |
    fzf --ansi --multi | sed 's#.*\(https*://\)#\1#' | xargs open
}
