#!/bin/sh

echo ">>> Installing Nginx"

# Installing Nginx
sudo yum install -y nginx

# Starting Nginx
sudo /etc/init.d/nginx start