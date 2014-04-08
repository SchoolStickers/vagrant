#!/bin/sh

# Install Memcached
sudo yum install -y memcached

# Starting memcached
sudo /etc/init.d/memcached start

sudo chkconfig --levels 235 memcached on