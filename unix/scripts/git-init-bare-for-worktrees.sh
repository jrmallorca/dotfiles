#!/usr/bin/env bash
set -e

# Examples of call:
# git-init-bare-for-worktrees .
# => Initialises the current repo with

# Moves all the administrative git files (a.k.a $GIT_DIR) under .bare directory.
#
# Plan is to create worktrees as siblings of this directory.
# Example targeted structure:
# .bare
# main
# new-awesome-feature
# hotfix-bug-12
# ...
git init --bare . .bare
echo "gitdir: ./.bare" >.git

# Explicitly sets the remote origin fetch so we can fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
