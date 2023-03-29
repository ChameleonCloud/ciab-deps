#!/bin/bash

# commits to rebase onto new upstream branch
# get the difference between our xena branch and the upstream xena branch, then apply that different on top of the upstream yoga branc

current_origin_branch="origin/chameleoncloud/xena"
current_upstream_branch="upstream/stable/xena"
next_upstream_branch="upstream/stable/yoga"
next_local_branch="chameleoncloud/yoga"

latest_common_commit="$(git merge-base $current_origin_branch $current_upstream_branch)"
echo "will rebase the following commits onto $next_upstream_branch"
commits_to_cherrypick="$(git log --pretty=oneline $current_upstream_branch..$current_origin_branch)"
echo "${commits_to_cherrypick}"

git checkout $next_local_branch
git rebase --onto $next_upstream_branch $current_upstream_branch $current_origin_branch


# git checkout -b chameleoncloud/yoga
# git rebase upstream/stable/yoga
