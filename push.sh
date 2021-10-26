#!/bin/bash

set -e

###
# FUNCTIONS
###

check_tag_value() {
  # Use git branch name for tag
  if [ -z "$TAG_NAME" ]; then
    # Check branch name for tag value
    BRANCH_NAME=$( git rev-parse --symbolic-full-name --abbrev-ref HEAD 2>/dev/null )

    if [ -z "$BRANCH_NAME" ] || [ "$BRANCH_NAME" == "HEAD" ]; then
      echo "error: git project not detected, or not initalised properly"
      die "expecting valid tag/branch name (value was either HEAD or not present)."
    fi

    # Clean result
    BRANCH_NAME=${BRANCH_NAME##"heads/"}

    export TAG_NAME="$BRANCH_NAME"
  fi

  # Remove v character from tag name if present
  TAG_NAME=${TAG_NAME##"v"}
}

die() {
  msg="$1"
  echo -e "$msg\nAborting."
  exit 1
}


###
# MAIN
###

# Determine tag name
check_tag_value

# Build image
echo
echo " * Pushing k9s image version: $TAG_NAME ..."
echo

docker push awilmore/k9s:$TAG_NAME
docker push awilmore/k9s:latest

echo
echo " * Done."
echo
