#!/bin/sh

echo ">>> Installing RabbitMQ Server 3.2.3"

cd /usr/share
wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.3/rabbitmq-server-3.2.3-1.noarch.rpm
rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc
yum install -y rabbitmq-server-3.2.3-1.noarch.rpm

# Turn on the web UI
rabbitmq-plugins enable rabbitmq_management
service rabbitmq-server restart

# Rabbit-server needs to start on boot
chkconfig rabbitmq-server on