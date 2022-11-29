#!/bin/sh -l

# Fail if skopeo throws an error, e.g. due to an unknown image name
set -e
set -o pipefail

# Get layer digests of my image
OWN=$(skopeo inspect docker://"$1" | jq .Layers)

# Get layer digests of the parent image
PARENT=$(skopeo inspect docker://"$2" | jq .Layers)

# Check if all layers of parent are present in my image. If not, mine is out-of-date.
OUTOFDATE=$(jq -cn "$OWN - ($OWN - $PARENT) | .==[]")

# Return the result.
echo "out-of-date=$OUTOFDATE" >> $GITHUB_OUTPUT
