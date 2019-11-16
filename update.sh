#!/bin/bash

version=$(curl -fsSL "https://services.lidarr.audio/v1/update/nightly/changes?os=linux" | jq -r .[0].version)
[[ -z ${version} ]] && exit
find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG LIDARR_VERSION=.*$/ARG LIDARR_VERSION=${version}/g" {} \;
sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version}}/g" .drone.yml
echo "##[set-output name=version;]${version}"
