#!/bin/bash

currdir=$(pwd)

repos_list=$(grep "path" .gitmodules | cut -d "=" -f 2)

current_origin_branch="origin/chameleoncloud/xena"
current_upstream_branch="upstream/stable/xena"
next_upstream_branch="upstream/stable/yoga"
next_local_branch="chameleoncloud/yoga"

do_rebase() {

    git rebase --abort 2>/dev/null
    git checkout -b $next_local_branch 2>/dev/null || git checkout $next_local_branch 2>/dev/null
    git reset --hard $current_origin_branch 2>/dev/null
    git status


    # latest_common_commit="$(git merge-base $current_origin_branch $current_upstream_branch)"
    # # echo "will rebase the following commits onto $next_upstream_branch"
    # commits_to_cherrypick="$(git log --pretty=oneline $current_upstream_branch..$current_origin_branch)"
    # # echo "${commits_to_cherrypick}"

    # git checkout $next_local_branch
    git rebase -q --onto $next_upstream_branch $current_upstream_branch $next_local_branch
    git status
}



for repo in $repos_list
do
    cd "${currdir}/${repo}"
    do_rebase
    cd
done


# cmd1='git rev-list --count ..upstream/stable/xena 2>/dev/null ||:'
# cmd2='git rev-list --count upstream/stable/xena.. 2>/dev/null ||:'

# echo 'repo, behind, ahead'
# git submodule foreach --quiet 'echo $sm_path, `git rev-list --count ..upstream/stable/xena 2>/dev/null ||: `, `git rev-list --count upstream/stable/xena.. 2>/dev/null ||: `'
