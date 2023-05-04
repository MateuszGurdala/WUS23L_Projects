#!/bin/bash

PROXY_PORT=$1
BACKEND_IP=$2
BACKEND_PORT=$3

sudo apt update
sudo apt upgrade -y

#Install nginx
sudo apt install -y nginx

# Create an Nginx reverse-proxy configuration
cat >loadbalancer.conf <<EOL
server {
    listen $PROXY_PORT;

    location / {
        proxy_pass http://$BACKEND_IP:$BACKEND_PORT;
        include proxy_params;
    }
}
EOL

sudo mv loadbalancer.conf /etc/nginx/conf.d/loadbalancer.conf

sudo nginx -s reload