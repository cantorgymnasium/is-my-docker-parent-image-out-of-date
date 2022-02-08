# Is my docker parent image out-of-date?

[![Test](https://github.com/twiddler/is-my-docker-parent-image-out-of-date/actions/workflows/test.yml/badge.svg)](https://github.com/twiddler/is-my-docker-parent-image-out-of-date/actions/workflows/test.yml)

Well, ask no more! This github action has the answer! :sunglasses:

Keeping your parent image up-to-date is essential to provide your built images with the latest (security) patches. However, you might not want to stupidly rebuild your image everyday. Use this action to check if you really have to rebuild! :partying_face:

I haven't tested this with [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/), but I guess it should be able to (only) check the last stage that really makes it into your built image. Feel free to open a pull request.

## Inputs

| Name           | Type   | Description                                     |
| -------------- | ------ | ----------------------------------------------- |
| `parent-image` | String | The docker parent image you are building on top |
| `my-image`     | String | Your image which uses `FROM [parent-image]`     |

## Output

| Name          | Type   | Description                                                                                    |
| ------------- | ------ | ---------------------------------------------------------------------------------------------- |
| `out-of-date` | String | 'true' if `my-image` does **not** use the latest version of `parent-image`, 'false' otherwise. |

## Example

If you want to rebuild your image when and only when its parent image changes, you could add an action like this to your project:

```yaml
name: Rebuild image when parent-image changes

# Regularly check at 4 AM
on:
  schedule:
    - cron: "0 4 * * *"

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      # Checkout your repository. You don't need this for the check to work, but putting it here saves you an "if: ..."
      - name: Checkout
        uses: actions/checkout@v2

      # Now check if our parent image changed. The result will be available at `steps.[id of this step].outputs.out-of-date`
      - name: Check if we have to even do all this
        id: check
        uses: twiddler/is-my-docker-parent-image-out-of-date@v1
        with:
          parent-image: nginx:1.21.0
          my-image: user/app:latest

      # We only want to build and push if our parent image changed.
      - name: Build and push
        uses: docker/build-push-action@v2
        with:
          context: .
          push: true
          tags: user/app:latest
        # Add this line to all the steps you want to skip
        if: steps.check.outputs.out-of-date == 'true'
```
