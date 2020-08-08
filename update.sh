#!/bin/bash

branch=$(curl -u "${GITHUB_ACTOR}:${GITHUB_TOKEN}" -fsSL "https://api.github.com/repos/lidarr/lidarr/pulls?state=open&base=develop" | jq -r 'sort_by(.updated_at) | .[] | select((.head.repo.full_name == "lidarr/Lidarr") and (.head.ref | contains("dependabot") | not)) | .head.ref' | tail -n 1)
version=$(curl -fsSL "https://lidarr.servarr.com/v1/update/${branch}/changes?os=linux" | jq -r .[0].version)
[[ -z ${version} ]] && exit 1
[[ ${version} == "null" ]] && exit 0
sed -i "s/{LIDARR_VERSION=[^}]*}/{LIDARR_VERSION=${version}}/g" .drone.yml
sed -i "s/{LIDARR_BRANCH=[^}]*}/{LIDARR_BRANCH=${branch}}/g" .drone.yml
echo "##[set-output name=version;]${branch}-${version}"
