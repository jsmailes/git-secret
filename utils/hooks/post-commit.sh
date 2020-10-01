#!/usr/bin/env bash

set -e

BRANCH_NAME=$(git branch | grep '\*' | sed 's/* //')

if [[ "$BRANCH_NAME" == 'master' ]]; then
  # Compare script version and the latest tag:
  NEWEST_TAG=$(git describe --abbrev=0 --tags)
  SCRIPT_VERSION=$(bash "${PWD}/git-secret" --version)

  if [[ "$NEWEST_TAG" != "v${SCRIPT_VERSION}" ]]; then
    # Create new release:
    git tag -a "v${SCRIPT_VERSION}" -m "version $SCRIPT_VERSION"
    echo "Created new tag 'v${SCRIPT_VERSION}'"
  fi
fi
