if [[ $GITFZF_ASCII_MODE = true ]]; then
  SYMBOL_BRANCH='b'
  SYMBOL_REMOTE='r'
  SYMBOL_TAG='t'
else
  SYMBOL_BRANCH=''
  SYMBOL_REMOTE=''
  SYMBOL_TAG=''
fi

git_local_branches() {
  local lastcheckout=($(git log -g --grep-reflog 'checkout' --format="%gs" | sed -E 's/.*to (.*)/\1/' | awk '!x[$0]++' | tail -n+2))
  for branch in "${lastcheckout[@]}"; do
    if git show-ref "refs/heads/${branch}" &> /dev/null; then
      echo "${SYMBOL_BRANCH}  ${branch}"
    fi
  done
}

git_remote_branches() {
  git branch -r --sort=-committerdate | grep -v HEAD | sed "s|^[^/]*/|${SYMBOL_REMOTE}  |"
}

git_stashed_files() {
  git status -s | awk '/^[^ ?]/'
}

git_changed_files() {
  git status -s | awk '/^.[^ ?]/'
}

git_unstaged_files() {
  git status -s | awk '/^.\S/'
}

##############[ git add ]###############

_fzf_complete_ga() {
  _fzf_complete "--multi" "$@" < <(
    git_unstaged_files
  )
}

_fzf_complete_ga_post() {
  awk '{print $2}'
}

############[ git checkout ]############

_fzf_complete_gco() {
  _fzf_complete "--multi" "$@" < <(
    git_changed_files
    git_local_branches
    git_remote_branches
    git tag | sed "s|^|${SYMBOL_TAG}  |"
  )
}

_fzf_complete_gco_post() {
  awk '{print $2}'
}

#############[ git reset ]##############

_fzf_complete_grh() {
  _fzf_complete "--multi" "$@" < <(
    git_stashed_files
  )
}

_fzf_complete_grh_post() {
  awk '{print $2}'
}

##############[ git diff ]##############

_fzf_complete_gd() {
  _fzf_complete "--multi" "$@" < <(
    git_changed_files
  )
}

_fzf_complete_gd_post() {
  awk '{print $2}'
}

##########[ git diff --cached ]#########

_fzf_complete_gdca() {
  _fzf_complete "--multi" "$@" < <(
    git_stashed_files
  )
}

_fzf_complete_gdca_post() {
  awk '{print $2}'
}
