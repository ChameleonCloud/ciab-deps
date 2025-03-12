#!/bin/bash

# meant to be run by git submodule foreach
# variables avail are $sm_path, $displaypath, $sha1, $toplevel

# echo $sm_path $displaypath $sha1 $toplevel
orig_remote="$(git remote get-url origin)"

upstream_remote="${orig_remote/chameleoncloud/openstack}"
# add upstream if missing
if ! git remote get-url upstream; then
    git remote add upstream $upstream_remote
fi

# fetch refs from upstream
git fetch --all

git log ..ussuri-eol
