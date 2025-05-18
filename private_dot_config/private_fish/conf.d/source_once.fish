# This is to lazy load certain slow things so fish stays snappy
if set -q SOURCED_ONCE
return
end

set -gx SOURCED_ONCE
set --local wd "$(dirname (status --current-filename))"
source $wd/../os.fish

if type -q chezmoi
    chezmoi completion fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q fzf
    fzf --fish | source
end

if type -q orbctl
    orbctl completion fish | source
end

if type -q brew
    fish_add_path /opt/homebrew/bin/
    fish_add_path /opt/homebrew/sbin/
    fish_add_path /opt/homebrew/opt/openjdk/bin/
end

if type -q cargo
    fish_add_path ~/.cargo/bin/
end

### Path ###
fish_add_path ~/.bin
fish_add_path ~/.local/bin
