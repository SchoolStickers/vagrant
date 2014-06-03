#!/bin/sh

echo ">>> Installing Base Packages"

# Add EPEL repo
sudo su -c 'rpm -Uvh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm'

# Install base packages
sudo yum update -y
sudo yum install -y git-core vim curl wget htop bzip2

echo ">>> Installing *.xip.io self-signed SSL"

SSL_DIR="/etc/ssl/xip.io"
DOMAIN="*.xip.io"
PASSPHRASE="vagrant"

SUBJ="
C=US
ST=Connecticut
O=Vaprobash
localityName=New Haven
commonName=$DOMAIN
organizationalUnitName=
emailAddress=
"

sudo mkdir -p "$SSL_DIR"

sudo openssl genrsa -out "$SSL_DIR/xip.io.key" 1024
sudo openssl req -new -subj "$(echo -n "$SUBJ" | tr "\n" "/")" -key "$SSL_DIR/xip.io.key" -out "$SSL_DIR/xip.io.csr" -passin pass:$PASSPHRASE
sudo openssl x509 -req -days 365 -in "$SSL_DIR/xip.io.csr" -signkey "$SSL_DIR/xip.io.key" -out "$SSL_DIR/xip.io.crt"

# Copy hosts from files dir if it exists
if [ -f /vagrant/files/hosts ]; then
	echo " * Copying hosts file"
	cp -f /vagrant/files/hosts /etc/hosts
fi

# Copy limits from files dir if it exists
if [ -f /vagrant/files/security/limits.conf ]; then
	echo " * Copying limits file"
	cp -f /vagrant/files/security/limits.conf /etc/security/limits.conf
fi

# Copy limits from files dir if it exists
if [ -f /vagrant/files/sysctl.conf ]; then
	echo " * Copying sysctl file"
	cp -f /vagrant/files/sysctl.conf /etc/sysctl.conf
	sysctl -p
fi
