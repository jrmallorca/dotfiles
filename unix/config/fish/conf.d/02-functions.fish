function abbr-erase-all --description 'Erase all abbreviations'
    while true
        read -l -P "This will erase all your abbreviations. You sure? [y/N] " confirm
        switch $confirm
            case Y y
                break
            case '' N n
                return 1
        end
    end
    for abbr_name in (abbr -l)
        abbr -e $abbr_name
    end
    set -q MY_ABBR_SET && set -e MY_ABBR_SET
end

function gcl -d 'Clone a repository with using a username and repository name' -a username repository
    # Check if username and repository are non-empty then git clone
    if set -q username[1] repository[1]
        git clone git@github.com:$username/$repository.git
    else
        printf 'Missing either username or repository name'
    end
end

function gswr -d 'Create local branch that tracks an existing remote branch'
    set remote_branch (git branch --remote | fzf --ansi | tr -d "[:blank:]")
    set local_branch (echo "$remote_branch" | cut -d "/" -f2-)
    git switch -c "$local_branch" --track "$remote_branch"
end

function gd -d 'Git diff'
    set -l is_git (git rev-parse --git-dir 2>/dev/null) # Check if current directory is within a git directory

    # If it is a git directory, git diff selected files
    if [ -n "$is_git" ]
        cd (git rev-parse --show-toplevel) # Go to git root directory
        set -l preview git diff $argv --color=always -- {-1} # Set the preview command of fzf
        git diff $argv --name-only | # Get git diffs
            fzf --multi --ansi --preview="$preview" # Pipe diffs into fzf
    else
        echo "fatal: not a git repository (or any of the parent directories): .git"
    end
end

function gswbr -d 'Create a local branch that tracks a remote branch of the same name' -a branchname
    # Check if branch name is non-empty
    if set -q branchname[1]
        git switch -c $branchname --track origin/$branchname
    else
        printf 'Missing branch name'
    end
end

function gsetup -d 'Set up a new repository using a repository name'
    set repository (basename $PWD) # Assume repository name is the same in GitHub
    set username jrmallorca # Set username in GitHub
    git init # Initialise repository
    git add -A # Add all changes in repository
    git commit -m "Initial commit" # Commit all changes
    git remote add origin \  # Link remote repository
    git@github.com:$username/$repository.git
    git push -u origin main # Push all changes to remote repository
end

function zf -d 'Go to last directory before quitting lf'
    set -l temp (mktemp) # Create a temporary file

    lf -last-dir-path "$temp" $argv # Put the last directory before quitting into temp
    # and listen for other flags

    if [ -f "$temp" ] # Check if temp is a file
        set -l dest (cat "$temp") # Get destination from temp
        rm "$temp" # Remove temp

        if [ -d "$dest" ] # Check if destination is a directory
            z "$dest" # Change directory to destination
        end
    end
end

function sr -d 'Search and replace in current folder' -a fromText toText
    # Check fromText is not empty
    if set -q fromText[1]
        rg $fromText --files-with-matches | xargs sed -i "s%$fromText%$toText%g"
    else
        printf 'Missing fromText'
    end
end

function mr -d 'Open Moon+ Reader Pro in Waydroid'
    sudo mount --bind ~/Documents/ ~/.local/share/waydroid/data/media/0/Documents
    waydroid app launch com.flyersoft.moonreader
end

function wd -d 'Start Waydroid session'
    waydroid session start &
end
