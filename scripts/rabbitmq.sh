#!/bin/sh

# Taken from http://sensuapp.org/docs/0.12/rabbitmq

sudo yum install -y erlang

sudo su -c 'rpm --import http://www.rabbitmq.com/rabbitmq-signing-key-public.asc'
sudo su -c 'rpm -Uvh http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.1/rabbitmq-server-3.2.1-1.noarch.rpm'

# Starting RabbitMQ
sudo /etc/init.d/rabbitmq-server start

sudo chkconfig rabbitmq-server on