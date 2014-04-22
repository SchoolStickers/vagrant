#!/bin/sh

# Taken from https://www.varnish-cache.org/installation/redhat

echo ">>> Installing Varnish"

[[ -z "$1" ]] && { echo "!!! Server IP not set. Check the Vagrant file."; exit 1; }
[[ -z "$2" ]] && { echo "!!! Nginx port not set. Check the Vagrant file."; exit 1; }
[[ -z "$3" ]] && { echo "!!! Varnish port not set. Check the Vagrant file."; exit 1; }

sudo su -c 'rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el6/noarch/varnish-release/varnish-release-3.0-1.el6.noarch.rpm'

sudo yum install -y varnish

# Varnish config
sed -i "s/VARNISH_LISTEN_PORT=.*/VARNISH_LISTEN_PORT=$3/" /etc/sysconfig/varnish

# Copy default from files dir if it exists
if [ -f /vagrant/files/default.vcl ]; then
	cp -f /vagrant/files/default.vcl /etc/varnish/default.vcl
fi

# Starting Varnish
sudo /etc/init.d/varnish start

sudo chkconfig varnish on