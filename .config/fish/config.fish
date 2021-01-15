set fish_greeting ""
fish_vi_key_bindings

# Set the cursor shapes for the different vi modes.
set fish_cursor_default     block      blink
set fish_cursor_insert      line       blink
set fish_cursor_replace_one underscore blink
set fish_cursor_visual      block

# sudoedit abbr
abbr se 'sudoedit'

# Fzf fish abbr
# abbr vf '__fzf_search_current_dir | commandline | xargs -r $EDITOR ; commandline -r ""'
abbr vf 'commandline -i "nvim " | __fzf_search_current_dir'
# abbr vdot 'cd ~/dotfiles ; __fzf_search_current_dir | commandline | xargs -r $EDITOR ; commandline -r ""'
abbr vdot 'cd ~/dotfiles ; commandline -i "nvim " | __fzf_search_current_dir'
# abbr vuni 'cd /mnt/d/University ; __fzf_search_current_dir | commandline | xargs -r $EDITOR ; commandline -r ""'
abbr vuni 'cd /mnt/d/University ; commandline -i "nvim " | __fzf_search_current_dir'
# abbr cdot 'cd ~/dotfiles ; cd (__fzf_search_current_dir | commandline) ; commandline -r ""'
abbr cdot 'cd ~/dotfiles ; commandline -i "cd " | __fzf_search_current_dir'
# abbr cuni 'cd ~/mnt/d/University ; cd (__fzf_search_current_dir | commandline) ; commandline -r ""'
abbr cdot 'cd ~/mnt/d/University ; commandline -i "cd " | __fzf_search_current_dir'

# nvim abbr
abbr v 'nvim'
export EDITOR='nvim'

# Changing directory abbr
abbr cdd 'cd /mnt/d'
abbr uni 'cd /mnt/d/University'
abbr cdc 'cd ~/.config'
abbr dot 'cd ~/dotfiles'

# dotfiles make config abbr
abbr mc 'make config'

# nmcli abbr (Wifi)
abbr ns 'nmcli c show'
abbr nd 'nmcli c down'
abbr nu 'nmcli c up'
abbr nc 'nmcli -a d wifi connect'

# googler abbr
abbr g 'googler'

# firefox abbr
abbr fanime 'daemon firefox https://9anime.to/home &'
abbr fkdrama 'daemon firefox https://dramacool.so/ &'
abbr fgit 'daemon firefox https://github.com/ &'
abbr fbb 'daemon firefox https://www.ole.bris.ac.uk/ &'

# mpv lofi youtube stream no audio
abbr lofi 'mpv --no-video --ytdl-format=91 https://youtu.be/5qap5aO4i9A'

# youtube on mpv alias
abbr yv 'googler -w youtube.com --url-handler mpv'

# Git abbr
abbr ga 'git add'
abbr ga. 'git add .'
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
