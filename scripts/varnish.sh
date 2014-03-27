#!/bin/sh

# Taken from https://www.varnish-cache.org/installation/redhat

echo ">>> Installing Varnish"

sudo su -c 'rpm --nosignature -i http://repo.varnish-cache.org/redhat/varnish-3.0/el6/noarch/varnish-release/varnish-release-3.0-1.el6.noarch.rpm'

sudo yum install -y varnish