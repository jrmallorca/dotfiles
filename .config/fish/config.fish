set fish_greeting ""
fish_vi_key_bindings

# Remap autocompletion
bind -M insert \ce accept-autosuggestion

# nvim abbr
abbr vim 'nvim'
export EDITOR='nvim'
alias fd='fdfind'
alias bat='batcat'

# Changing directory abbr
abbr cdd 'cd /mnt/d'
abbr cdc 'cd ~/.config'

# nmcli abbr
abbr nmcs 'nmcli c show'
abbr nmcd 'nmcli c down'
abbr nmcu 'nmcli c up'
abbr nmcc 'nmcli -a d wifi connect'

# Git abbr
abbr g 'git'
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

# ripgrep configurations
set -x RIPGREP_CONFIG_PATH ~/.ripgrep/rc
