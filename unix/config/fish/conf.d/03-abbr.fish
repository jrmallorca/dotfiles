if not set -q MY_ABBR_SET
    set -U MY_ABBR_SET true
end

# General
abbr -a xx 'chmod +x'
abbr -a mc 'sh $HOME/dotfiles/unix/scripts/user/make-config.sh'

# Package manager
if [ "$OSTYPE" = Linux ]
    if type -q paru
        abbr -a p 'paru -Syu'
        abbr -a prm 'paru -Rs'
    else if type -q apt
        abbr -a p 'sudo apt update && sudo apt upgrade && sudo apt install'
        abbr -a prm 'sudo apt autoremove && sudo apt remove'
    end
else if [ "$OSTYPE" = MacOS ]
    abbr -a p 'brew upgrade && brew install'
    abbr -a prm 'brew uninstall'
end

# (Un)mounting
abbr -a mntc 'sudo mount /dev/sda1 /mnt/c'
abbr -a umntc 'sudo umount /mnt/c'
abbr -a mntp 'simple-mtpfs --device 1 /mnt/phone/'
abbr -a umntp 'fusermount -u /mnt/phone/'

# Find files and directories

# Common directories

# Edit
abbr -a ef 'zf -command search_edit'
abbr -a er 'z / && zf -command search_edit'
abbr -a ec 'z ~/.config && zf -command search_edit'
abbr -a eE 'z /etc && zf -command search_edit'
abbr -a eU 'z /usr && zf -command search_edit'
abbr -a emc 'z /mnt/c && zf -command search_edit'
abbr -a emph 'z /mnt/phone && zf -command search_edit'
abbr -a evw 'z ~/Documents/work-vault && zf -command search_edit'
abbr -a eg 'z (git rev-parse --show-toplevel) && zf -command search_edit'

if [ "$OSTYPE" = WSL ]
    abbr -a e. 'z $USERPROFILE/dotfiles && zf -command search_edit'
    abbr -a eh 'z $USERPROFILE && zf -command search_edit'
    abbr -a ep 'z $USERPROFILE/projects && zf -command search_edit'
    abbr -a edw 'z $USERPROFILE/Downloads && zf -command search_edit'
else
    abbr -a e. 'z ~/dotfiles && zf -command search_edit'
    abbr -a eh 'z ~/ && zf -command search_edit'
    abbr -a ep 'z ~/projects && zf -command search_edit'
    abbr -a edw 'z ~/Downloads && zf -command search_edit'
end

# Navigate
abbr -a zr 'z / && zf'
abbr -a zc 'z ~/.config && zf'
abbr -a zE 'z /etc && zf'
abbr -a zU 'z /usr && zf'
abbr -a zmc 'z /mnt/c && zf'
abbr -a zvw 'z ~/Documents/work-vault && zf'
abbr -a zg 'z (git rev-parse --show-toplevel) && zf'

if [ "$OSTYPE" = WSL ]
    abbr -a z. 'z $USERPROFILE/dotfiles && zf'
    abbr -a zh 'z $USERPROFILE && zf'
    abbr -a zp 'z $USERPROFILE/projects && zf'
    abbr -a zdw 'z $USERPROFILE/Downloads && zf'
else
    abbr -a z. 'z ~/dotfiles && zf'
    abbr -a zh 'z ~/ && zf'
    abbr -a zp 'z ~/projects && zf'
    abbr -a zdw 'z ~/Downloads && zf'
end

# Editor
abbr -a se sudoedit
abbr -a e nvim

# Git
abbr -a ga 'git ls-files --modified --others --exclude-standard --deduplicate | fzf --ansi --multi --print0 --preview="git diff --color=always -- {-1} | diff-so-fancy" | xargs -0 -o git add'
abbr -a ga. 'git add .'
abbr -a gaa 'git add -A'
abbr -a gb 'git branch'
abbr -a gbd 'git branch | fzf --ansi | xargs git branch -d'
abbr -a gbl 'git blame'
abbr -a gc 'git commit -S -m'
abbr -a gca 'git commit --amend -S'
abbr -a gcam 'git commit --amend -S -m'
abbr -a gcoc 'git log --oneline | fzf --ansi | head -n1 | awk \'{print $1;}\' | xargs git checkout'
abbr -a gcp 'git cherry-pick'
abbr -a gd 'git diff --name-only | fzf --multi --ansi --preview="git diff --color=always -- {-1} | diff-so-fancy"'
abbr -a gdc 'git diff --cached --name-only | fzf --multi --ansi --preview="git diff --cached --color=always -- {-1} | diff-so-fancy"'
abbr -a gf 'git fetch'
abbr -a gl 'git log'
abbr -a gm 'git merge'
abbr -a gp 'git push'
abbr -a gpf 'git push --force-with-lease'
abbr -a gpl 'git pull'
abbr -a gplrom 'git pull --rebase origin main'
abbr -a gr 'git ls-files --modified --exclude-standard --deduplicate | fzf --ansi --multi --print0 --preview="git diff --color=always -- {-1} | diff-so-fancy" | xargs git restore'
abbr -a grs 'git diff --cached --name-only | fzf --multi --ansi --preview="git diff --cached --color=always -- {-1} | diff-so-fancy" | xargs -o git restore --staged'
abbr -a grpo 'git remote prune origin'
abbr -a grb 'git rebase'
abbr -a gs 'git status'
abbr -a gsw 'git branch | fzf --ansi | xargs git switch'
abbr -a gswc 'git switch -c'
abbr -a gst 'git stash'
abbr -a gstp 'git stash pop'
abbr -a gg 'git log --graph --full-history --all --color --pretty=format:"%x1b[31m%h%x09%x1b[32m%d%x1b[0m%x20%s"'
abbr -a gresign 'git rebase --exec \'git commit --amend --no-edit -n -S\' -i'

# GitHub CLI
abbr -a ghi 'gh issue'
abbr -a ghic 'gh issue create --assignee @me'
abbr -a ghil 'gh issue list'
abbr -a ghpr 'gh pr'
abbr -a ghprc 'gh pr create --assignee @me --base'

# Add flashcards to anki
abbr -a aa add-flashcards-to-anki.sh
