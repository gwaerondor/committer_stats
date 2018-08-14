#!/bin/bash

if [ -z "${1}" ]
then
    GIT_USER="$(git config --global --list | grep user.name | cut -d= -f2)"
else
    GIT_USER="${1}"
fi

main() {
        exit_if_not_repository
        local branch changes user_commits all_commits percentage
        branch="$(get_branch)"
        changes="$(lines_changed)"
        user_commits="$(get_user_commits)"
        all_commits="$(get_all_commits)"
        percentage="$(calculate_percentage ${user_commits} ${all_commits})"
        echo "Stats for ${GIT_USER} on ${branch}:"
        echo "  Commits: ${user_commits} (${percentage}% of all commits)"
        echo "  Lines: ${changes}"
        echo "  Line delta: $((changes))"
        echo ""
        echo "Stats for all users on ${branch}:"
        echo "  Commits: ${all_commits}"
}

exit_if_not_repository() {
    git status 1> /dev/null 2>&1 || print_error_and_exit
}

print_error_and_exit() {
    echo "fatal: Not a git repository" >&2
    exit 1
}

get_branch() {
    git branch | grep -P '^\*' | cut -d' ' -f2
}

lines_changed() {
    git log --author="${GIT_USER}" --pretty=tformat: --numstat \
        | awk 'BEGIN {ins=0; rem=0}; {ins+=$1; rem+=$2} END {print "+" ins " -" rem}'
}

get_user_commits() {
    git rev-list HEAD --count --author="${GIT_USER}"
}

get_all_commits() {
    git rev-list HEAD --count
}

calculate_percentage() {
    local num denom part percentage
    num="${1}"
    denom="${2}"
    echo "scale=6; ${num}/${denom}" | bc | awk '{printf "%.4f\n", $0*100}'
}

main