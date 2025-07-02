# Set vi key bindings
fish_vi_key_bindings

# Removes fish greeting
set fish_greeting

# Replace cd with z
if [ "$OSTYPE" = MacOS ]
    /opt/homebrew/bin/zoxide init fish | source
else
    /usr/bin/zoxide init fish | source
end

# Activate mise
if status is-interactive
    mise activate fish | source
else
    mise activate fish --shims | source
end
