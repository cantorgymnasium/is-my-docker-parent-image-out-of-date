# Only out-of-date combinations of `my-image` and `parent-image` from the test workflow should end up here. If any other combination ends up here, we need to throw an error.

echo "This script only runs if the check thinks my image is out-of-date. Let's see if our expectations agree."

OWN=$1
PARENT=$2

[ "$OWN" = "nginx/nginx-ingress:1.12.0" ] && [ "$PARENT" = "nginx:1.21.0" ] && exit 0

exit 1
