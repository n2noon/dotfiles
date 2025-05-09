# https://fishshell.com/docs/current/language.html
# https://github.com/jorgebucaran/cookbook.fish
# https://fishshell.com/docs/current/interactive.html#interactive
# https://fishshell.com/docs/current/faq.html
# run bind to see keybindings!

set --local wd ~/.config/fish

### Source extra scripts ###
source $wd/source_once.fish

### Keybinds ###
# bind ctrl+z to toggle fg
bind \cz 'fg 2> /dev/null'
bind alt-l 'eza --group-directories-first'

### Environment variables ###
# kitty needs this for ime input
if set -q KITTY_WINDOW_ID
    set -gx GLFW_IM_MODULE ibus
end

### Abbreviations ###
abbr -a pk pkill
abbr -a cl clear
abbr -a --position anywhere xclip fish_clipboard_copy
abbr -a --position anywhere pbpaste fish_clipboard_paste
## Some directories
abbr -a proj cd ~/projects/
abbr -a home cd ~/


### Program specific ###
if type -q brew
    set -gx SHELL /opt/homebrew/bin/fish
    set -gx HOMEBREW_AUTO_UPDATE_SECS 604800
    set -gx HOMEBREW_NO_ENV_HINTS y
    abbr -a bi brew install
    abbr -a bup brew upgrade
    abbr -a bu brew remove
    abbr -a bs brew search
    abbr -a bl brew list
    abbr -a binf brew info
    set -p fish_complete_path /opt/homebrew/share/fish/completions
    set -p fish_complete_path /opt/homebrew/share/fish/vendor_completions.d
end

if type -q just
    abbr -a j just
end

if type -q cargo
    abbr -a ci cargo init
    abbr -a cil cargo init --lib
    abbr -a ca cargo add
    abbr -a cb cargo build
    abbr -a cr cargo run
    abbr -a ct cargo test
end

# maybe i should move to helix...
if type -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end
# muscle memory...
abbr -a n $EDITOR

if type -q chezmoi
    abbr -a cm chezmoi
    abbr -a cmr chezmoi re-add
    abbr -a cme chezmoi edit
end

if type -q fzf
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    set -gx FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
end

if type -q eza
    abbr -a l eza --group-directories-first
    abbr -a ll eza -l --group-directories-first
    abbr -a tree --set-cursor eza --tree --level=%
end

# bat 
if type -q bat
    # Colour man pages
    set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
    set -gx PAGER bat
    abbr -a b bat
    abbr -a c bat
    abbr -a cat bat

    abbr -a catlog batlog
    abbr -a clog batlog
    abbr -a blog batlog

    # Help files
    abbr -a bathelp bat --plain --language=help
    abbr -a --position anywhere -- -h --help \&\| bat --plain --language=help
end

# Wine
if type -q wine
    abbr -a vn WINEPREFIX=~/VNs LC_MESSAGES=ja_JP.UTF-8 wine
end

abbr -a todo $EDITOR ~/Notes/todo.md

# cht.sh
if type -q cht.sh
    complete -c cht.sh -xa '(curl -s cheat.sh/:list)'
    abbr -a cht --set-cursor 'cht.sh % &| bat'
end

if type -q git
    source $wd/git-alias.fish
    # abbr -a g git
    # abbr -a gc git commit
    # abbr -a gcm git commit --message
    # abbr -a ga git add
    # abbr -a gs git status
    # abbr -a gl git log
    # abbr -a gp git pull
    # abbr -a gf git fetch
    # abbr -a gr git rebase
end

if type -q yt-dlp
    abbr -a yt yt-dlp
    abbr -a dl "yt-dlp --write-auto-sub -4 --sub-lang 'en.*' --embed-subs --cookies-from-browser firefox"
    abbr -a dlj "yt-dlp --write-auto-sub -4 --sub-lang 'en.*,ja' --embed-subs --cookies-from-browser firefox"
end

if type -q lazygit
    abbr -a lg lazygit
end

# Sudo last command with just !!
abbr -a !! --position anywhere --function last_history_item

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /Users/kalk/.lmstudio/bin
# End of LM Studio CLI section

