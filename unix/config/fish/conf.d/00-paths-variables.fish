# OS Type
switch (uname)
    case Linux
        set -gx OSTYPE "Linux"
    case Darwin
        set -gx OSTYPE "MacOS"
    case '*'
        if [ type -q wslpath ]
            set -gx OSTYPE "WSL"
        else
            set -gx OSTYPE "unknown"
        end
end

if [ "$OSTYPE" = "Linux" ]
    fish_add_path $HOME/git-installs/scli
else if [ "$OSTYPE" = "MacOS" ]
    set -gx EDITOR /opt/homebrew/bin/nvim
    fish_add_path /opt/homebrew/bin
else if [ "$OSTYPE" = "WSL" ]
    set -gx USERPROFILE (wslpath (wslvar USERPROFILE))
    fish_add_path RUST_SRC_PATH $HOME/.cargo/bin
else
    set -gx EDITOR /usr/bin/nvim
end

# Zoxide
set -gx _ZO_ECHO '1'
set -gx _ZO_DATA_DIR $HOME/.local/share

# GPG
set -x GPG_TTY (tty)

# nvm.fish
set -x nvm_default_version lts
