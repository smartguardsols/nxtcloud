#!/bin/bash

# Stop all containers from AIO interface
sudo docker stop $(sudo docker ps -q --filter "label=nextcloud-aio")

# Stop the mastercontainer
sudo docker stop nextcloud-aio-mastercontainer

# Stop domaincheck container if still running
sudo docker stop nextcloud-aio-domaincheck

# Remove all containers associated with Nextcloud AIO
sudo docker rm $(sudo docker ps -aq --filter "label=nextcloud-aio")

# Delete the docker network
sudo docker network rm nextcloud-aio

# Remove all volumes associated with Nextcloud AIO
sudo docker volume rm $(sudo docker volume ls --quiet --filter "label=nextcloud-aio")

echo "All Nextcloud AIO containers and volumes have been removed."
