#!/bin/bash

set -xev

sudo apt-get install -y lego

mkdir -p ~/certs
cd ~/certs
export HOSTINGDE_API_KEY=$(cat ~/.sec/.hosting_api_key)
export HOSTINGDE_ZONE_NAME=cluster-4.de
lego --email ferenc.hechler@gmail.com --dns hostingde -d '*.vps-b.cluster-4.de' -d vps-b.cluster-4.de --accept-tos run

TLS_CERT=.lego/certificates/_.vps-b.cluster-4.de.crt
TLS_KEY=.lego/certificates/_.vps-b.cluster-4.de.key
