# OS Type
switch (uname)
    case Linux
        set -gx OSTYPE Linux
    case Darwin
        set -gx OSTYPE MacOS
    case '*'
        if [ type -q wslpath ]
            set -gx OSTYPE WSL
        else
            set -gx OSTYPE unknown
        end
end

if [ "$OSTYPE" = Linux ]
    fish_add_path $HOME/git-installs/scli
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/bin
else if [ "$OSTYPE" = MacOS ]
    set -gx EDITOR /opt/homebrew/bin/nvim

    fish_add_path /opt/homebrew/bin
    fish_add_path /usr/local/share/dotnet/x64
    fish_add_path $HOME/Library/Python/3.8/bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/bin
    fish_add_path $HOME/.jenv/bin
else if [ "$OSTYPE" = WSL ]
    set -gx USERPROFILE (wslpath (wslvar USERPROFILE))

    fish_add_path RUST_SRC_PATH $HOME/.cargo/bin
else
    set -gx EDITOR /usr/bin/nvim
end

set -gx BROWSER zen-browser

# Zoxide
set -gx _ZO_ECHO 1
set -gx _ZO_DATA_DIR $HOME/.local/share

set -gx EDITOR nvim

# GPG
set -x GPG_TTY (tty)

# nvm.fish
set -x nvm_default_version lts

# Android Development
fish_add_path /opt/android-sdk/tools/emulator
