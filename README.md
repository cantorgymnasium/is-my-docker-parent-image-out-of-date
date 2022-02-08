# Is my docker parent image out-of-date?

[![Test](https://github.com/twiddler/docker-image-update-checker/actions/workflows/test.yml/badge.svg)](https://github.com/twiddler/docker-image-update-checker/actions/workflows/test.yml)
[![GitHub release badge](https://badgen.net/github/release/twiddler/docker-image-update-checker/stable)](https://github.com/twiddler/docker-image-update-checker/releases/latest)
[![GitHub license badge](https://badgen.net/github/license/twiddler/docker-image-update-checker)](https://github.com/twiddler/docker-image-update-checker/blob/main/LICENSE)
[![GitHub Workflows badge](https://badgen.net/runkit/twiddler/twiddler-workflow)](https://github.com/search?q=docker-image-update-checker+path%3A.github%2Fworkflows%2F+language%3AYAML&type=Code)

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

on:
  schedule:
    - cron: "0 4 * * *"

jobs:
  docker:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v2

      - name: Check if update available
        id: check
        uses: twiddler/docker-image-update-checker@v1
        with:
          parent-image: nginx:1.21.0
          image: user/app:latest

      - name: Build and push
        uses: docker/build-push-action@v2
        with:
          context: .
          push: true
          tags: user/app:latest
        if: steps.check.outputs.needs-updating == 'true'
```
