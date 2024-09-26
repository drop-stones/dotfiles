function git-switch() {
  _fzf_git_each_ref --no-multi | xargs git switch
}

function git-switch-detach() {
  commit=$(_fzf_git_hashes --no-multi)
  [[ -z $commit ]] && return 1
  git switch --detach $commit
}

function git-worktree() {
  cd "$(_fzf_git_worktrees --no-multi)"
}
