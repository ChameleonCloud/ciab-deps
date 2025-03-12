#!/bin/bash


# rm -rf repos


ensure_repo(){
    local repo_ref=$1
    local repo_url=$2
    local repo_path=$3

    if [[ ! -d $repo_path ]]; then    
        git clone --single-branch --branch "$repo_ref" "$repo_url" "$repo_path"
    fi
}

check_upstream(){

    local upstream_ref=$1
    local upstream_url=$2
    local repo_path=$3
    local repo_name=$4

    pushd "$repo_path"
    git remote add upstream $baserepo
    git fetch "upstream" "$baseref"

    git --no-pager log --pretty=oneline "${curref}..${baseref}" > "../../${repo_name}-upstream.txt"
    git --no-pager log --pretty=oneline "${baseref}..${curref}" > "../../${repo_name}-local.txt"

    popd
}

rm -rf repos
mkdir -p repos
while IFS=$'\t' read -r name currepo curref baserepo baseref; do
    ensure_repo "$curref" "$currepo" "repos/$name"
    check_upstream "$baseref" "$baserepo" "repos/$name" $name
done < <(yq -r '.deps[] | [.name, .current.repo, .current.ref, .base.repo, .base.ref] | @tsv' deps.yml)
