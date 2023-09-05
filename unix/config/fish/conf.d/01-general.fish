# Set vi key bindings
fish_vi_key_bindings

# Removes fish greeting
set fish_greeting

# Replace cd with z
# Enable jenv
if [ "$OSTYPE" = MacOS ]
    /opt/homebrew/bin/zoxide init fish | source
    status --is-interactive; and jenv init - | source
else
    /usr/bin/zoxide init fish | source
end
