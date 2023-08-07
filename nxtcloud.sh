#!/bin/bash

# Step 1: Create Docker volume for Nextcloud data
docker volume create \
  --driver local \
  --name nextcloud_aio_nextcloud_datadir \
  --opt type=none \
  --opt device=~/nxt/data \
  --opt o=bind

# Step 2: Run Nextcloud All-In-One Docker container
sudo docker run \
  --sig-proxy=false \
  --name nextcloud-aio-mastercontainer \
  --restart always \
  --publish 80:80 \
  --publish 8082:8080 \
  --publish 8443:8443 \
  --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
  --volume ~/nxt/data:/var/www/html \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  nextcloud/all-in-one:latest
