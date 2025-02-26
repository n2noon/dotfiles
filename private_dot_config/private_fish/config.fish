# bind ctrl+z to toggle fg
bind \cz 'fg 2> /dev/null'

# kitty needs this for ime input
set -gx GLFW_IM_MODULE ibus

abbr -a pk pkill
#abbr -a im beet im
#abbr -a bim beet im

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
end

if type -q cargo
    fish_add_path ~/.cargo/bin/
end

fish_add_path ~/.scripts

# maybe i should move to helix...
if type -q nvim
    set -gx EDITOR nvim
    abbr -a leet nvim -c Leet
else
    set -gx EDITOR vim
end

if type -q chezmoi
    abbr -a cm chezmoi
    abbr -a cmr chezmoi re-add
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
    set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
end

if type -q eza
    abbr -a l eza --icons
    abbr -a ls eza --icons
    abbr -a ll eza --icons -l
    abbr -a --set-cursor tree eza --icons --tree --level=%
end

abbr -a c cat

# bat for coloured man pages
if type -q bat
    set -gx MANPAGER "sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"
    abbr -a b bat
end

# muscle memory...
abbr -a n $EDITOR

#abbr -a --set-cursor encrypt age -p -o %.age

# Wine
if type -q wine
    abbr -a vn WINEPREFIX=~/VNs LC_MESSAGES=ja_JP.UTF-8 wine
end

# Git
abbr -a g git
abbr -a gc git commit
abbr -a ga git add
abbr -a gs git status
abbr -a gl git log
abbr -a gp git pull
abbr -a gf git fetch
abbr -a gr git rebase
abbr -a lg lazygit
abbr -a gcm git commit --message

abbr -a --position anywhere pbcopy fish_clipboard_copy
abbr -a --position anywhere xclip fish_clipboard_copy
abbr -a --position anywhere pbpaste fish_clipboard_paste

abbr -a proj cd ~/projects/
abbr -a home cd ~/

abbr -a j just


set PATH $PATH /Users/kalk/.local/bin

# fish_update_completions

# launch my music daemons...
#mpd & mpdscribble &
