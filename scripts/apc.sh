#!/bin/sh

echo ">>> Installing & configuring APC"
yum install -y php54w-pecl-apc

# Modify shm_size to cope with Magento
sed -i "s/apc.shm_size=.*/apc.shm_size=512M/" /etc/php.d/apc.ini
set -i "s/apc.enable_cli=.*/apc.enable_cli=1/" /etc/php.d/apc.ini
