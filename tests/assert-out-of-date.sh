FILENAME=$(basename $BASH_SOURCE)

# Only out-of-date combinations of `my-image` and `parent-image` from the test workflow should end up here. If any other combination ends up here, we need to throw an error.

echo "[$FILENAME] This script only runs if the check thinks my image is out-of-date. Let's see if our expectations agree."

OWN=$1
PARENT=$2

# There are fewer up-to-date combinations to check. Throw an error if we encounter one of those.
[ "$OWN" = "nginx/nginx-ingress:1.12.0" ] && [ "$PARENT" = "nginx:1.21.0" ] && exit 1

echo "[$FILENAME] All tests passed."
