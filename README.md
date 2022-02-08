# Docker Image Update Checker Action

[![Test](https://github.com/twiddler/docker-image-update-checker/actions/workflows/test.yml/badge.svg)](https://github.com/twiddler/docker-image-update-checker/actions/workflows/test.yml)
[![GitHub release badge](https://badgen.net/github/release/twiddler/docker-image-update-checker/stable)](https://github.com/twiddler/docker-image-update-checker/releases/latest)
[![GitHub license badge](https://badgen.net/github/license/twiddler/docker-image-update-checker)](https://github.com/twiddler/docker-image-update-checker/blob/main/LICENSE)
[![GitHub Workflows badge](https://badgen.net/runkit/twiddler/twiddler-workflow)](https://github.com/search?q=docker-image-update-checker+path%3A.github%2Fworkflows%2F+language%3AYAML&type=Code)

Action to check if the parent image was updated and your image (published on DockerHub) needs to be rebuilt. This action will use Docker's API to compare the parent layers of your image with the `parent-image`, without the need to pull the images.

## Inputs

| Name           | Type   | Description                        |
| -------------- | ------ | ---------------------------------- |
| `parent-image` | String | Parent Docker Image                |
| `my-image`     | String | Your image based on `parent-image` |

## Output

| Name             | Type   | Description                                               |
| ---------------- | ------ | --------------------------------------------------------- |
| `needs-updating` | String | 'true' or 'false' if the image needs to be updated or not |

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
