#!/usr/bin/env bash
set -e

git worktree add $1 &&
    git branch --set-upstream-to=origin/$(git branch --show-current)
