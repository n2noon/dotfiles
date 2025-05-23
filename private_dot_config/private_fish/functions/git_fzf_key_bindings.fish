function __git_fzf_is_in_git_repo
  command -s -q git
    and git rev-parse HEAD >/dev/null 2>&1
end

function __git_fzf_git_status
  __git_fzf_is_in_git_repo; or return
  git -c color.status=always status --short | \
    fzf -m --ansi --preview 'git diff --color=always HEAD -- {-1} | head -500' | \
    cut -c4- | \
    sed 's/.* -> //'
  commandline -f repaint
end

function __git_fzf_git_branch
  __git_fzf_is_in_git_repo; or return
  git branch -a --color=always | \
    grep -v '/HEAD\s' | \
    fzf -m --ansi --preview-window right:70% --preview 'git log --color=always --oneline --graph --date=short \
      --pretty="format:%C(auto)%cd %h%d %s %C(magenta)[%an]%Creset" \
      (echo {} | sed s/^..// | cut -d" " -f1) | head -'$LINES | \
    sed 's/^..//' | cut -d' ' -f1 | \
    sed 's#^remotes/##'
  commandline -f repaint
end

function __git_fzf_git_tag
  __git_fzf_is_in_git_repo; or return
  git tag --sort -version:refname | \
    fzf -m --ansi --preview-window right:70% --preview 'git show --color=always {} | head -'$LINES
  commandline -f repaint
end

function __git_fzf_git_log
  __git_fzf_is_in_git_repo; or return
  git log --color=always --graph --date=short --format="%C(auto)%cd %h%d %s %C(magenta)[%an]%Creset" | \
    fzf -m --ansi --reverse --preview 'git show --color=always (echo {} | grep -o "[a-f0-9]\{7,\}") | head -'$LINES | \
    sed -E 's/.*([a-f0-9]{7,}).*/\1/'
  commandline -f repaint
end

# https://gist.github.com/junegunn/8b572b8d4b5eddd8b85e5f4d40f17236
function git_fzf_key_bindings -d "Set custom key bindings for git+fzf"
  bind \cg\cs __git_fzf_git_status
  bind \cg\cb __git_fzf_git_branch
  bind \cg\ct __git_fzf_git_tag
  bind \cg\cf __git_fzf_git_log
end
