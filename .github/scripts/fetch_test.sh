#!/usr/bin/env bash

# Overview:
# Builds a JSON string what images and their channels to process
# Outputs:
# {"changes":[{"app":"ubuntu","channels":["focal","jammy"]},...]}

shopt -s lastpipe

declare -A app_channel_array
find ./apps -name metadata.json5 | while read -r metadata; do
    declare -a __channels=()
    app="$(jq --raw-output '.app' "${metadata}")"
    jq --raw-output -c '.channels | .[]' "${metadata}" | while read -r channels; do
        channel="$(jq --raw-output '.name' <<< "${channels}")"
        stable="$(jq --raw-output '.stable' <<< "${channels}")"
        published_version=$(./.github/scripts/versions/published.sh "${app}" "${channel}" "${stable}")
        upstream_version=$(./.github/scripts/versions/upstream.sh "${app}" "${channel}" "${stable}")
        if [[ "${published_version#*v}" != "${upstream_version}" ]]; then
            echo "${app}/${channel}: ${published_version#*v} -> ${upstream_version}"
            __channels+=("${channel}")
        fi
    done
    if [[ "${#__channels[@]}" -gt 0 ]]; then
        app_channel_array[$app]="${__channels[*]}"
    fi
done

declare -a changes_array=()
for app in "${!app_channel_array[@]}"; do
    #shellcheck disable=SC2086
    changes_array+=("$(jo app="$app" channels="$(jo -a -- -s ${app_channel_array[$app]})")")
done

#shellcheck disable=SC2048,SC2086
echo "::set-output name=changes::$(jo changes="$(jo -a ${changes_array[*]})")"