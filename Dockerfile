# Use Docker-in-Docker image to access docker/login-action authorization
FROM docker:20-dind

# Install packages
RUN apk add skopeo jq

# Copy script from repository to the filesystem of the container
COPY entrypoint.sh /entrypoint.sh

# Script to execute when the docker container starts up
ENTRYPOINT ["/entrypoint.sh"]