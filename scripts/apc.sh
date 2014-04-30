#!/bin/sh

echo ">>> Installing & configuring APC"
yum install -y php54w-pecl-apc

# Copy apc.ini from files dir if it exists
if [ -f /vagrant/files/php.d/apc.ini ]; then
	echo " * Copying APC config file"
	cp -f /vagrant/files/php.d/apc.ini /etc/php.d/apc.ini
fi
