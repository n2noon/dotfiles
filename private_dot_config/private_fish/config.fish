## Path (brew on darwin)
fish_add_path /opt/homebrew/bin/
fish_add_path /opt/homebrew/sbin/
fish_add_path /opt/homebrew/opt/openjdk/bin/
fish_add_path ~/.cargo/bin/
fish_add_path ~/.scripts

set -gx SHELL /opt/homebrew/bin/fish
# kitty needs this for ime input
set -gx GLFW_IM_MODULE ibus

# maybe i should move to helix...
set -gx EDITOR nvim

# bat for coloured man pages
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

# bind ctrl+z to toggle fg
bind \cz 'fg 2> /dev/null'

# Yazi
# (commented out dumb hack to get ueberzugpp in zellij lol i stopped using zellij)
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    #NVIM=1 NVIM_LOG_FILE=1 yazi $argv --cwd-file="$tmp"
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

zoxide init fish | source
fzf --fish | source

# eza
abbr -a ls eza --icons always
abbr -a ll eza --icons always -l

# muscle memory...
abbr -a lf y
abbr -a nv $EDITOR
abbr -a n $EDITOR

# Package manager (mac)
abbr -a bi brew install
abbr -a bup brew upgrade
abbr -a bu brew remove
abbr -a bs brew search
abbr -a bl brew list
abbr -a binf brew info
#abbr -a --set-cursor encrypt age -p -o %.age

# Wine
abbr -a vn WINEPREFIX=~/VNs LC_MESSAGES=ja_JP.UTF-8 wine

# Git (add more!)
abbr -a gc git commit
abbr -a ga git add
abbr -a gp git pull
abbr -a gf git fetch
abbr -a gr git rebase
abbr -a lg lazygit
abbr -a gcm git commit --message

abbr -a --position anywhere pbcopy fish_clipboard_copy
abbr -a --position anywhere pbpaste fish_clipboard_paste


abbr -a proj cd ~/projects/
# Some scripts


# Created by `pipx` on 2024-10-07 21:18:26
set PATH $PATH /Users/kalk/.local/bin

# launch my music daemons...
#mpd & mpdscribble &

