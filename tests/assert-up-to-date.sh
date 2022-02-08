# Only up-to-date combinations of `my-image` and `parent-image` from the test workflow should end up here. If any other combination ends up here, we need to throw an error.

echo "This script only runs if the check thinks my image is up-to-date. Let's see if our expectations agree."

# This should be the exact inverse of the other script.
./expect-out-of-date.sh $1 $2 && exit 1
