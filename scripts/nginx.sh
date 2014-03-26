#!/bin/sh

echo ">>> Installing Nginx"

# Adding Yum repo
cat > /etc/yum.repos.d/nginx.repo << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/x86_64/
gpgcheck=0
enabled=1
EOF

# Installing Nginx
sudo yum install -y nginx

# Starting Nginx
sudo /etc/init.d/nginx start