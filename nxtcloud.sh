#!/bin/bash

# Step 1: Create Docker volume for Nextcloud data
docker volume create \
  --driver local \
  --name nextcloud_aio_nextcloud_datadir \
  -o type=none \
  -o device="~/nxt/data" \
  -o o=bind

# Step 2: Run Nextcloud All-In-One Docker container
sudo docker run \
  --sig-proxy=false \
  --name nextcloud-aio-mastercontainer \
  --restart always \
  --publish 80:80 \
  --publish 8082:8080 \
  --publish 8443:8443 \
  --env APACHE_PORT=11000 \
  --env APACHE_IP_BINDING=0.0.0.0 \
  --env SKIP_DOMAIN_VALIDATION=true \
  --env NEXTCLOUD_DATADIR="nextcloud_aio_nextcloud_datadir" \
  --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
  --volume ~/nxt/data:/var/www/html \
  --volume /var/run/docker.sock:/var/run/docker.sock:ro \
  nextcloud/all-in-one:latest

echo "Nextcloud All-In-One setup completed."
