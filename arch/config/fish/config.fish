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

function vf -d 'Finds file in current directory and executes nvim'
    commandline -i "nvim " # Insert "nvim "
    __fzf_search_current_dir # Find file in current directory
    if test (count (commandline --tokenize)) = 2 # If found something...
        commandline -f execute # Press enter
    else
        commandline -r "" # Clear commandline buffer
    end
end

function zf -d 'Finds file in current directory and changes to that directory'
    __fzf_search_current_dir # Find file in current directory
    commandline -f execute # Press enter
end

function grt -d 'Go to the root of the git repository'
    set -l root_dir (git rev-parse --show-toplevel) # Get root directory

    # Check if we're in a git repository and go to root directory if so
    if [ -d "$root_dir" ]
        z $root_dir
    else
        echo "fatal: not a git repository (or any of the parent directories): .git"
    end
end

function gcl -d 'Clone a repository with using a username and repository name' -a username repository
    if set -q username[1] repository[1]
        git clone git@github.com:$username/$repository.git
    else
        printf 'Missing either username or repository name'
    end
end

function gsetup -d 'Set up a new repository using a repository name'
    set repository (basename $PWD)
    git init
    git add -A
    git commit -m "Initial commit"
    git remote add origin git@github.com:jrmallorca/$repository.git
    git push -u origin main
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
abbr mntph 'simple-mtpfs --device 1 /mnt/phone/'
abbr umntph 'fusermount -u /mnt/phone/'

# Changing directories
abbr zr 'z /'
abbr zh 'z ~/'
abbr zp 'z ~/Projects'
abbr z. 'z ~/dotfiles/arch'
abbr zc 'z ~/.config'
abbr zdw 'z ~/Downloads'
abbr zE 'z /etc'
abbr zU 'z /usr'
abbr zmd 'z /mnt/d'
abbr zmdn 'z ~/mnt/d/Notes'
abbr zmdu 'z ~/mnt/d/University'
abbr zmp 'z /mnt/phone'

# Search and edit
abbr v. 'z ~/dotfiles/arch ; vf'
abbr vws 'z ~/dotfiles/workspaces ; vf'
abbr vuni 'z /mnt/d/University ; vf'
abbr vno 'z /mnt/d/Notes ; vf'
abbr vpro 'z ~/Projects ; vf'

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
abbr v 'nvim'

# Dotfiles
abbr mc 'z ~/dotfiles/arch && make configuration && prevd'

# nmcli
abbr ns 'nmcli c show'
abbr nd 'nmcli c down'
abbr nu 'nmcli c up'
abbr nc 'nmcli -a d wifi connect'

# Stocks
abbr stocks ticker -w AMD,AAPL,CRSP,CRSR,GME,AMC,SQ,NIO --show-fundamentals --show-separator

# Git
abbr ga 'git add'
abbr ga. 'git add .'
abbr gaa 'git add -A'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -S -m'
abbr gca 'git commit --amend -S -m'
abbr gco 'git checkout'
abbr gcob 'git checkout -b'
abbr gcp 'git cherry-pick'
abbr gd 'git diff'
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
