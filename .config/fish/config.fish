set fish_greeting ""
fish_vi_key_bindings

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# Remap autocompletion
bind -M insert \ce accept-autosuggestion

# sudoedit abbr
abbr se 'sudoedit'

# mpv lofi youtube stream no audio
abbr lofi 'mpv --no-video --ytdl-format=91 https://youtu.be/5qap5aO4i9A'

# youtube on mpv alias
abbr yv 'googler -w youtube.com --url-handler mpv $argv'

# nvim abbr
abbr vim 'nvim'
export EDITOR='nvim'
alias fd='fdfind'
alias bat='batcat'

# Changing directory abbr
abbr cdd 'cd /mnt/d'
abbr cduni 'cd /mnt/d/University'
abbr cdc 'cd ~/.config'
abbr cddot 'cd ~/dotfiles'

# dotfiles make config abbr
abbr mc 'make config'

# nmcli abbr (Wifi)
abbr ns 'nmcli c show'
abbr nd 'nmcli c down'
abbr nu 'nmcli c up'
abbr nc 'nmcli -a d wifi connect'

# googler abbr
abbr g 'googler'

# Git abbr
abbr ga 'git add'
abbr gb 'git branch'
abbr gbl 'git blame'
abbr gc 'git commit -m'
abbr gca 'git commit --amend -m'
abbr gco 'git checkout'
abbr gcp 'git cherry-pick'
abbr gd 'git diff'
abbr gf 'git fetch'
abbr gl 'git log'
abbr gm 'git merge'
abbr gp 'git push'
abbr gpf 'git push --force-with-lease'
abbr gpl 'git pull'
abbr gr 'git remote'
abbr grb 'git rebase'
abbr gs 'git status'
abbr gst 'git stash'

# PATH configurations
set -x PATH $PATH ~/flutter/bin
