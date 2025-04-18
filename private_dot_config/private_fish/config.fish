### Keybinds ###
# bind ctrl+z to toggle fg
bind \cz 'fg 2> /dev/null'

### Environment variables ###
# kitty needs this for ime input
set -gx GLFW_IM_MODULE ibus
set --local wd "$(dirname (status --current-filename))"

### Path ###
fish_add_path ~/.scripts
fish_add_path ~/.bin
fish_add_path ~/.local/bin
fish_add_path ~/.lmstudio/bin

### Abbreviations ###
abbr -a pk pkill
abbr -a --position anywhere xclip fish_clipboard_copy
abbr -a --position anywhere pbpaste fish_clipboard_paste
## Some directories
abbr -a proj cd ~/projects/
abbr -a home cd ~/

### Program specific ###
if type -q brew
    fish_add_path /opt/homebrew/bin/
    fish_add_path /opt/homebrew/sbin/
    fish_add_path /opt/homebrew/opt/openjdk/bin/
    set -gx SHELL /opt/homebrew/bin/fish
    set -gx HOMEBREW_AUTO_UPDATE_SECS 60*60*24*7
    set -gx HOMEBREW_NO_ENV_HINTS y
    abbr -a bi brew install
    abbr -a bup brew upgrade
    abbr -a bu brew remove
    abbr -a bs brew search
    abbr -a bl brew list
    abbr -a binf brew info
    if test -d (brew --prefix)"/share/fish/completions"
        set -p fish_complete_path (brew --prefix)/share/fish/completions
    end
    if test -d (brew --prefix)"/share/fish/vendor_completions.d"
        set -p fish_complete_path (brew --prefix)/share/fish/vendor_completions.d
    end
end

if type -q just
    abbr -a j just
end

if type -q cargo
    fish_add_path ~/.cargo/bin/
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
    chezmoi completion fish | source
end

if type -q yazi
    function y
        set tmp (mktemp -t "yazi-cwd.XXXXXX")
        yazi $argv --cwd-file="$tmp"
        if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
            builtin cd -- "$cwd"
        end
        rm -f -- "$tmp"
    end
end

if type -q zoxide
    zoxide init fish | source
end

if type -q fzf
    fzf --fish | source
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
    set -g FZF_CTRL_T_COMMAND "command find -L \$dir -type f 2> /dev/null | sed '1d; s#^\./##'"
end

if type -q eza
    # This is an alias to make Alt+L work
    alias ls="eza --icons --group-directories-first"
    abbr -a l eza --icons --group-directories-first
    abbr -a ll eza --icons -l --group-directories-first
    abbr -a tree --set-cursor eza --icons --tree --level=%
end

# bat 
if type -q bat
    # Colour man pages
    set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
    set -gx PAGER bat
    abbr -a b bat
    abbr -a c bat
    abbr -a cat bat

    # See tail of log, refreshed realtime
    function batlog -a file
        tail -f $file | bat --paging=never -l log
    end
    abbr -a catlog -f batlog
    abbr -a clog -f batlog
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
abbr -a lg lazygit
# abbr -a --set-cursor={} gcm git commit --message \"{}\"
