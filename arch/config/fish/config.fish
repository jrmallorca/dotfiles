fish_vi_key_bindings
set fish_greeting # Removes fish greeting

zoxide init fish | source

function cdf
    set tmp (mktemp)
    lf -last-dir-path=$tmp $argv
    if test -f "$tmp"
        set dir (cat $tmp)
        rm -f $tmp
        if test -d "$dir"
            if test "$dir" != (pwd)
                cd $dir
            end
        end
    end
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# Finds file in current directory and executes nvim
function vf
    commandline -i "nvim " # Insert "nvim "
    __fzf_search_current_dir # Find file in current directory
    if test (count (commandline --tokenize)) = 2 # If found something...
        commandline -f execute # Press enter
    else
        commandline -r "" # Clear commandline buffer
    end
end

# Finds file in current directory and changes to that directory
function zf
    __fzf_search_current_dir # Find file in current directory
    commandline -f execute # Press enter
end

# paru abbr
abbr p 'paru -Syu'
abbr prm 'paru -Rs'

# Mount phone
abbr mntph 'simple-mtpfs --device 1 /mnt/phone/'
abbr umntph 'fusermount -u /mnt/phone/'

# Changing directory abbr
abbr md 'z /mnt/d'
abbr uni 'z /mnt/d/University'
abbr no 'z /mnt/d/Notes'
abbr cfg 'z ~/.config'
abbr dot 'z ~/dotfiles/arch'
abbr pro 'z ~/Projects'

# Confirmation (command history)
abbr v. 'z ~/dotfiles/arch ; vf'
abbr vws 'z ~/dotfiles/workspaces ; vf'
abbr vuni 'z /mnt/d/University ; vf'
abbr vno 'z /mnt/d/Notes ; vf'
abbr vpro 'z ~/Projects ; vf'
abbr z. 'z ~/dotfiles/arch ; zf'
abbr zws 'z ~/dotfiles/workspaces ; zf'
abbr zuni 'z /mnt/d/University ; zf'
abbr zno 'z /mnt/d/Notes ; zf'
abbr zpro 'z ~/Projects ; zf'

# tmux abbr
abbr t 'tmux'
abbr tls 'tmux ls'
abbr tn 'tmux new -s'
abbr ta 'tmux attach-session'
abbr tat 'tmux attach-session -t'
abbr tk 'tmux kill-session'
abbr rmtr 'rm -rf ~/.tmux/resurrect/*'

# Chat abbr
abbr we 'weechat'
abbr wh 'whatscli'

# Calcurse abbr
abbr cal 'calcurse'

# Editor abbr
abbr se 'sudoedit'
abbr v 'nvim'

# dotfiles make config abbr
abbr mc 'z ~/dotfiles/arch && make configuration && prevd'

# nmcli abbr (Wifi)
abbr ns 'nmcli c show'
abbr nd 'nmcli c down'
abbr nu 'nmcli c up'
abbr nc 'nmcli -a d wifi connect'

# Stocks abbr
abbr stocks ticker -w AMD,AAPL,CRSP,CRSR,GME,AMC,SQ,NIO --show-fundamentals --show-separator

# Browser-related abbr
abbr g 'googler'
abbr b 'buku'
abbr fanime 'daemon firefox https://9anime.to/home &'
abbr fkdrama 'daemon firefox https://dramacool.so/ &'
abbr fgit 'daemon firefox https://github.com/ &'
abbr fbb 'daemon firefox https://www.ole.bris.ac.uk/ &'

# Play Lo-Fi Cafe on spt
abbr lofi 'spt p --uri spotify:playlist:37i9dQZF1DX9RwfGbeGQwP'

# youtube on mpv alias
abbr yv 'googler -w youtube.com --url-handler mpv'

# Git abbr
abbr ga 'git add'
abbr ga. 'git add .'
abbr gaa 'git add -A'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -S -m'
abbr gca 'git commit --amend -S -m'
abbr gco 'git checkout'
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

# GitHub CLI abbr
abbr ghil 'gh issue list'
abbr ghprc 'gh pr create --assignee @me --project "" --base main --title "" --body "" --web'

set -x GPG_TTY (tty)

# PATH configurations
# set PATH $PATH /opt/android-studio/bin 
# set PATH $PATH /opt/gradle/gradle-6.8.2/bin
set PATH $PATH /usr/lib/dart/bin
set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
set -gx ANDROID_SDK_ROOT /opt/android-sdk
