#!/bin/bash

currdir=$(pwd)

CHI_BRANCH="chameleoncloud/xena"
OS_BRANCH="upstream/stable/xena"

repos_list=$(grep "path" .gitmodules | cut -d "=" -f 2)

# echo $repos_list


for repo in $repos_list
do
    cd "${currdir}/${repo}"
    echo $repo `git rev-list --count .."${OS_BRANCH}" 2>/dev/null ||:`
    git log -q --pretty=oneline  .."${OS_BRANCH}" 2>/dev/null ||:
    cd
done


# cmd1='git rev-list --count ..upstream/stable/xena 2>/dev/null ||:'
# cmd2='git rev-list --count upstream/stable/xena.. 2>/dev/null ||:'

# echo 'repo, behind, ahead'
# git submodule foreach --quiet 'echo $sm_path, `git rev-list --count ..upstream/stable/xena 2>/dev/null ||: `, `git rev-list --count upstream/stable/xena.. 2>/dev/null ||: `'
