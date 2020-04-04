#!/usr/bin/env bash

if [[ "$CIRRUS_RELEASE" == "" ]]; then
  echo "Not a release. No need to deploy!"
  exit 0
fi

if [[ "$GITHUB_TOKEN" == "" ]]; then
  echo "Please provide GitHub access token via GITHUB_TOKEN environment variable!"
  exit 1
fi

echo "Uploading..."
name="higan-$CIRRUS_RELEASE-$CIRRUS_OS.zip"
curl -X POST \
    --data-binary @higan-nightly.zip \
    --header "Authorization: token $GITHUB_TOKEN" \
    --header "Content-Type: application/octet-stream" \
    "https://uploads.github.com/repos/$CIRRUS_REPO_FULL_NAME/releases/$CIRRUS_RELEASE/assets?name=$name"
