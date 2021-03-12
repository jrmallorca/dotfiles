fish_vi_key_bindings
set fish_greeting # Removes fish greeting

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# DOESN'T WORK IN ALACRITTY
# Set the cursor shapes for the different vi modes.
# set fish_cursor_default     block      blink
# set fish_cursor_insert      line       blink
# set fish_cursor_replace_one underscore blink
# set fish_cursor_visual      block

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
function cdf
    __fzf_search_current_dir # Find file in current directory
    commandline -f execute # Press enter
end

# Mount phone
abbr mntph 'simple-mtpfs --device 1 /mnt/phone/'
abbr umntph 'fusermount -u /mnt/phone/'

# Changing directory abbr
abbr md 'cd /mnt/d'
abbr uni 'cd /mnt/d/University'
abbr no 'cd /mnt/d/Notes'
abbr cfg 'cd ~/.config'
abbr dot 'cd ~/dotfiles/arch'
abbr pro 'cd ~/Projects'

# Confirmation (command history)
abbr vdot 'cd ~/dotfiles/arch ; vf'
abbr vws 'cd ~/dotfiles/workspaces ; vf'
abbr vuni 'cd /mnt/d/University ; vf'
abbr vno 'cd /mnt/d/Notes ; vf'
abbr vpro 'cd ~/Projects ; vf'
abbr cdot 'cd ~/dotfiles/arch ; cdf'
abbr cws 'cd ~/dotfiles/workspaces ; cdf'
abbr cuni 'cd /mnt/d/University ; cdf'
abbr cno 'cd /mnt/d/Notes ; cdf'
abbr cpro 'cd ~/Projects ; cdf'

# tmux abbr
abbr t 'tmux'
abbr tls 'tmux ls'
abbr tn 'tmux new -s'
abbr ta 'tmux attach-session'
abbr tat 'tmux attach-session -t'

# Chat abbr
abbr we 'weechat'
abbr wh 'whatscli'

# Calcurse abbr
abbr cal 'calcurse'

# Editor abbr
abbr se 'sudoedit'
abbr v 'nvim'

# dotfiles make config abbr
abbr mc 'make configuration'

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

set -x GPG_TTY (tty)

# PATH configurations
# set PATH $PATH /opt/android-studio/bin 
# set PATH $PATH /opt/gradle/gradle-6.8.2/bin
set -gx JAVA_OPTS '-XX:+IgnoreUnrecognizedVMOptions'
set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk
set -gx ANDROID_SDK_ROOT /opt/android-sdk
