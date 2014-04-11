#!/bin/sh

# Taken from http://webtatic.com/packages/php54/

echo ">>> Installing PHP 5.4"

sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -y php54w php54w-common php54w-devel php54w-mysqlnd php54w-fpm php54w-gd php54w-pear php54w-pecl-xdebug php54w-xml php54w-pecl-apc

# xdebug Config if not present already
if grep -q "[XDEBUG]" /etc/php.d/xdebug.ini; then
	cat >> /etc/php.d/xdebug.ini << EOF
[XDEBUG]
xdebug.remote_enable = 1
xdebug.remote_connect_back = 1
xdebug.remote_port = 9000
xdebug.scream=1
xdebug.cli_color=1
xdebug.show_local_vars=1

; var_dump display
xdebug.var_display_max_depth = 5
xdebug.var_display_max_children = 256
xdebug.var_display_max_data = 1024
EOF
fi

# PHP Error Reporting config
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini
sed -i "s/html_errors = .*/display_errors = On/" /etc/php.ini

# PHP Date Timezone config
sed -i "s/;date.timezone =.*/date.timezone = UTC/" /etc/php.ini

# User config
sed -i "s/user = .*/user = vagrant/" /etc/php-fpm.d/www.conf
sed -i "s/group = .*/group = vagrant/" /etc/php-fpm.d/www.conf

# Starting PHP-FPM
sudo /etc/init.d/php-fpm start

sudo chkconfig php-fpm on