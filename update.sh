#!/bin/bash

version=$(curl -fsSL "https://api.github.com/repos/lidarr/lidarr/releases" | jq -r .[0].tag_name | sed s/v//g)
find . -type f -name '*.Dockerfile' -exec sed -i "s/ARG LIDARR_VERSION=.*$/ARG LIDARR_VERSION=${version}/g" {} \;
sed -i "s/{TAG_VERSION=.*}$/{TAG_VERSION=${version}}/g" .drone.yml
echo "##[set-output name=version;]${version}"
