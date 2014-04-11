#!/bin/sh

echo ">>> Installing AMQP"

# Install deps
yum install -y erlang libtool autoconf automake glibc xmlto doxygen openssl-devel ld-linux.so.2

# Add the extra c libs needed by the AMQP install
cd /usr/src
echo "... Cloning rabbitmq-c"
git clone git://github.com/alanxz/rabbitmq-c.git
cd rabbitmq-c
git submodule init
git submodule update

# Now build rabbit libs
echo "... Building librabbitmq"
autoreconf -i && ./configure && make && make install

# Install AMQP for php if its not already installed
if [[ ! -a /etc/php.d/amqp.ini ]]; then
	echo ">>> Installing AMQP"
	pecl install AMQP
	echo "extension=amqp.so" > /etc/php.d/amqp.ini
	service php-fpm restart
fi