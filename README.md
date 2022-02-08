# Is my docker parent image out-of-date?

[![Test](https://github.com/twiddler/is-my-docker-parent-image-out-of-date/actions/workflows/test.yml/badge.svg)](https://github.com/twiddler/is-my-docker-parent-image-out-of-date/actions/workflows/test.yml)
[![GitHub release badge](https://badgen.net/github/release/twiddler/is-my-docker-parent-image-out-of-date/stable)](https://github.com/twiddler/is-my-docker-parent-image-out-of-date/releases/latest)
[![GitHub license badge](https://badgen.net/github/license/twiddler/is-my-docker-parent-image-out-of-date)](https://github.com/twiddler/is-my-docker-parent-image-out-of-date/blob/main/LICENSE)
[![GitHub Workflows badge](https://badgen.net/runkit/twiddler/twiddler-workflow)](https://github.com/search?q=is-my-docker-parent-image-out-of-date+path%3A.github%2Fworkflows%2F+language%3AYAML&type=Code)

Well, ask no more! This github action has the answer! :sunglasses:

Keeping your parent image up-to-date is essential to provide your built with the latest (security) patches. However, you might not want to stupidly rebuild your image everyday. Use this action to check if you really have to rebuild! :partying-face:

## Inputs

| Name           | Type   | Description                                 |
| -------------- | ------ | ------------------------------------------- |
| `parent-image` | String | Parent docker image                         |
| `my-image`     | String | Your image which uses `FROM [parent-image]` |

## Output

| Name          | Type   | Description                                               |
| ------------- | ------ | --------------------------------------------------------- |
| `out-of-date` | String | 'true' or 'false' if the image needs to be updated or not |

## Example

```yaml
name: check docker images

# You might want to regularly check for a new parent image release
on:
  schedule:
    - cron: "0 4 * * *"

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Check if we have to even do all this
        id: check
        uses: twiddler/is-my-docker-parent-image-out-of-date@v1
        with:
          parent-image: nginx:1.21.0
          my-image: user/app:latest

      - name: Build and push
        uses: docker/build-push-action@v2
        with:
          context: .
          push: true
          tags: user/app:latest
        # Add this line to all the steps you want to skip
        if: steps.check.outputs.out-of-date == 'true'
```
