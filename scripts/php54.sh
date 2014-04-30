#!/bin/sh

echo ">>> Installing PHP 5.4"

sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -y php54w php54w-common php54w-devel php54w-mysqlnd php54w-fpm php54w-gd php54w-pear php54w-pecl-xdebug php54w-xml php54w-mcrypt php54w-mbstring

# Copy php.ini from files dir if it exists
if [ -f /vagrant/files/php.ini ]; then
	echo " * Copying PHP ini file"
	cp -f /vagrant/files/php.ini /etc/php.ini
fi

# Copy xdebug.ini from files dir if it exists
if [ -f /vagrant/files/php.d/xdebug.ini ]; then
	echo " * Copying Xdebug config file"
	cp -f /vagrant/files/php.d/xdebug.ini /etc/php.d/xdebug.ini
fi

# Copy php-fpm.conf from files dir if it exists
if [ -f /vagrant/files/php-fpm.conf ]; then
	echo " * Copying PHP-FPM config file"
	cp -f /vagrant/files/php-fpm.conf /etc/php-fpm.conf
fi

# Copy www.conf from files dir if it exists
if [ -f /vagrant/files/php-fpm.d/www.conf ]; then
	echo " * Copying PHP-FPM WWW pool file"
	cp -f /vagrant/files/php-fpm.d/www.conf /etc/php-fpm.d/www.conf
fi

# Starting PHP-FPM
sudo /etc/init.d/php-fpm restart

sudo chkconfig php-fpm on