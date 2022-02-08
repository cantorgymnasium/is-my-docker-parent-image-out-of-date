FILENAME=$(basename $BASH_SOURCE)

# Only up-to-date combinations of `my-image` and `parent-image` from the test workflow should end up here. If any other combination ends up here, we need to throw an error.

echo "[$FILENAME] This script only runs if the check thinks my image is up-to-date. Let's see if our expectations agree."

# This should be the exact inverse of the other script.
echo "[$FILENAME] We will call the other script and invert its exit code."
./tests/assert-out-of-date.sh $1 $2 && exit 1

echo "[$FILENAME] All tests passed."
