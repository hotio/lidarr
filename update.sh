#!/bin/bash

###################
version=$(curl -fsSL "https://services.lidarr.audio/v1/update/nightly/changes?os=linux" | jq -r .[0].version)
app=LIDARR
###################

location=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
cd "${location}" || exit 1

find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG ${app}_VERSION=.*$/ARG ${app}_VERSION=${version}/g" {} \;

if [[ -n "$(git status --untracked-files=no --porcelain)" ]]; then
    git add ./*.Dockerfile
    git commit -m "Updated version to: ${version}"
    echo "Updated version to: ${version}"
else
    echo "Version is still: ${version}"
fi
