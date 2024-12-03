#!/bin/bash

# https://github.com/nextcloud/all-in-one#nextcloud-all-in-one

set -xev

# For Linux and without a web server or reverse proxy (like Apache, Nginx, Caddy, Cloudflare Tunnel and else) already in place:
sudo docker run \
--init \
--sig-proxy=false \
--name nextcloud-aio-mastercontainer \
--restart always \
--publish 80:80 \
--publish 8080:8080 \
--publish 8443:8443 \
--volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
--volume /var/run/docker.sock:/var/run/docker.sock:ro \
--env NEXTCLOUD_DATADIR="/home/ferenc/ncdata" \
nextcloud/all-in-one:latest


echo setup by calling https://nextcloud.vps-b.cluster-4.de:8443

# cleanup container / volume / network / image: 
# https://thelinuxforum.com/articles/892-how-to-reset-uninstall-nextcloud-aio-completely

