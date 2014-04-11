#!/bin/sh

echo ">>> Installing Supervisor"
yum install -y supervisor

/etc/init.d/supervisord start

# Start it on boot
chkconfig supervisord on
