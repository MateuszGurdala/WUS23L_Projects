#!/bin/bash

BALANCER_PORT="$1"
BACKEND_1_IP_PORT="$2"
BACKEND_2_IP_PORT="$3"

sudo apt update
sudo apt upgrade -y
sudo apt install -y nginx

# Create an Nginx configuration file in the current directory
cat >loadbalancer.conf <<EOL
upstream backend {
    server $BACKEND_1_IP_PORT;
    server $BACKEND_2_IP_PORT;
}

server {
    listen $BALANCER_PORT;

    location /petclinic/api {
        proxy_pass http://backend;
    }
}
EOL

sudo mv loadbalancer.conf /etc/nginx/conf.d/loadbalancer.conf

sudo nginx -s reload
