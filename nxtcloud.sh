#!/bin/bash

# Get the absolute path to the data directory
DATA_DIR=$(pwd)

# Step 1: Create Docker volume for Nextcloud data
VOLUME_NAME="nextcloud_aio_nextcloud_datadir"
docker volume create \
  --driver local \
  --name "$VOLUME_NAME" \
  --opt type=none \
  --opt device="$DATA_DIR" \
  --opt o=bind

# Step 2: Run Nextcloud All-In-One Docker container
sudo docker run \
  --sig-proxy=false \
  --name nextcloud-aio-mastercontainer \
  --restart always \
  --publish 80:80 \
  --publish 8080:8080 \
  --publish 8443:8443 \
  --env APACHE_PORT=11000 \
  --env APACHE_IP_BINDING=0.0.0.0 \
  --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
  --volume "$DATA_DIR":/var/www/html \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  nextcloud/all-in-one:latest
