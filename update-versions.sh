#!/bin/bash

branch="nightly"
version=$(curl -fsSL "https://lidarr.servarr.com/v1/update/${branch}/changes?os=linuxmusl&runtime=netcore&arch=x64" | jq -r .[0].version)
[[ -z ${version} ]] && exit 0
[[ ${version} == "null" ]] && exit 0
version_json=$(cat ./VERSION.json)
jq '.version = "'"${version}"'" | .branch = "'"${branch}"'"' <<< "${version_json}" > VERSION.json
