#!/bin/sh

echo ">>> Installing Nginx"

[[ -z "$1" ]] && { echo "!!! IP address not set. Check the Vagrant file."; exit 1; }
[[ -z "$2" ]] && { echo "!!! Nginx port not set. Check the Vagrant file."; exit 1; }

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

# Copy nginx configs
if [ -f /vagrant/files/nginx/nginx.conf ]; then
	echo " * Copying Nginx config file"
    cp -f /vagrant/files/nginx/nginx.conf /etc/nginx/nginx.conf
fi

# Copy nginx host configs
if [ -d /vagrant/files/nginx/conf.d ]; then
	echo " * Copying Nginx host config files"
    cp -rf /vagrant/files/nginx/conf.d/* /etc/nginx/conf.d
fi

# Starting Nginx
sudo /etc/init.d/nginx restart
sudo /etc/init.d/php-fpm restart

sudo chkconfig nginx on