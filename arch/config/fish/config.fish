###########
# GENERAL #
###########

# Set vi key bindings
fish_vi_key_bindings

# Removes fish greeting
set fish_greeting

# Replace cd with z
zoxide init fish | source

#############
# FUNCTIONS #
#############

function cdf -d 'Go to last directory before quitting lf'
    set -l temp (mktemp) # Create a temporary file

    lf -last-dir-path "$temp" $argv # Put the last directory before quitting into temp
                                    # and listen for other flags

    if [ -f "$temp" ]             # Check if temp is a file
        set -l dest (cat "$temp") # Get destination from temp
        rm "$temp"                # Remove temp

        if [ -d "$dest" ]         # Check if destination is a directory
            z "$dest"             # Change directory to destination
        end
    end
end

function gd -d 'Git diff'
    set -l is_git (git rev-parse --git-dir 2>/dev/null) # Check if current directory is within a git directory

    # If it is a git directory, git diff selected files
    if [ -n "$is_git" ]
        cd (git rev-parse --show-toplevel)                   # Go to git root directory
        set -l preview git diff $argv --color=always -- {-1} # Set the preview command of fzf 
        git diff $argv --name-only |                         # Get git diffs
            fzf --multi --ansi --preview="$preview"          # Pipe diffs into fzf
    else
        echo "fatal: not a git repository (or any of the parent directories): .git"
    end
end

function gcl -d 'Clone a repository with using a username and repository name' -a username repository
    # Check if username and repository are non-empty then git clone
    if set -q username[1] repository[1]
        git clone git@github.com:$username/$repository.git
    else
        printf 'Missing either username or repository name'
    end
end

function gsetup -d 'Set up a new repository using a repository name'
    set repository (basename $PWD) # Assume repository name is the same in GitHub
    set username jrmallorca        # Set username in GitHub
    git init                       # Initialise repository
    git add -A                     # Add all changes in repository
    git commit -m "Initial commit" # Commit all changes
    git remote add origin \        # Link remote repository
        git@github.com:$username/$repository.git
    git push -u origin main        # Push all changes to remote repository
end

#################
# ABBREVIATIONS #
#################

# General
abbr xx 'chmod +x'

# paru
abbr p 'paru -Syu'
abbr prm 'paru -Rs'

# (Un)mounting
abbr mntd 'sudo mount /dev/sda1 /mnt/d'
abbr umntd 'sudo umount /mnt/d'
abbr mntp 'simple-mtpfs --device 1 /mnt/phone/'
abbr umntp 'fusermount -u /mnt/phone/'

# Changing directories
abbr zr 'z / && cdf'
abbr zh 'z ~/ && cdf'
abbr zp 'z ~/Projects && cdf'
abbr z. 'z ~/dotfiles/arch && cdf'
abbr zc 'z ~/.config && cdf'
abbr zdw 'z ~/Downloads && cdf'
abbr zE 'z /etc && cdf'
abbr zU 'z /usr && cdf'
abbr zmd 'z /mnt/d && cdf'
abbr zmdn 'z ~/mnt/d/Notes && cdf'
abbr zmdu 'z ~/mnt/d/University && cdf'
abbr zmp 'z /mnt/phone && cdf'
abbr zg 'z (git rev-parse --show-toplevel) && cdf'

# Find and edit
abbr e. 'z ~/dotfiles/arch && cdf -command search_edit'
abbr emdu 'z /mnt/d/University && cdf -command search_edit'
abbr emdn 'z /mnt/d/Notes && cdf -command search_edit'
abbr ep 'z ~/Projects && cdf -command search_edit'
abbr eg 'z (git rev-parse --show-toplevel) && cdf -command search_edit'

# TMUX
abbr t 'tmux'
abbr tls 'tmux ls'
abbr tn 'tmux new -s'
abbr ta 'tmux attach-session'
abbr tat 'tmux attach-session -t'
abbr tk 'tmux kill-session'
abbr rmtr 'rm -rf ~/.tmux/resurrect/*'

# Chat
abbr we 'weechat'
abbr wh 'whatscli'
abbr s 'z ~/scli && ./scli'

# Editor
abbr se 'sudoedit'
abbr e 'nvim'

# Dotfiles
abbr mc 'z ~/dotfiles/arch && make configuration && prevd'

# nmcli
abbr ns 'nmcli c show'
abbr nd 'nmcli c down'
abbr nu 'nmcli c up'
abbr nc 'nmcli -a d wifi connect'

# Git
abbr ga 'git ls-files --modified --others --exclude-standard | fzf --ansi --multi --print0 --preview="bat {-1} --color=always" | xargs --null --open-tty git add'
abbr ga. 'git add .'
abbr gaa 'git add -A'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -S -m'
abbr gca 'git commit --amend -S -m'
abbr gco 'git branch | fzf --ansi | xargs git checkout'
abbr gcob 'git checkout -b'
abbr gcp 'git cherry-pick'
abbr gf 'git fetch'
abbr gl 'git log'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpl 'git pull'
abbr gplrom 'git pull --rebase origin main'
abbr gr 'git remote'
abbr grb 'git rebase'
abbr gs 'git status'
abbr gst 'git stash'
abbr gg 'git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
abbr gresign 'git rebase --exec \'git commit --amend --no-edit -n -S\' -i'

# GitHub CLI
abbr ghil 'gh issue list'
abbr ghprc 'gh pr create --assignee @me --project "" --base main --title "" --body "" --web'

set -x GPG_TTY (tty)

########
# PATH #
########

# Editor variable
set -gx EDITOR /usr/bin/nvim

# deno (Javascript LSP)
set PATH $PATH /home/joni/.deno/bin

# Flutter
set PATH $PATH /usr/lib/dart/bin
set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
set -gx ANDROID_SDK_ROOT /opt/android-sdk
