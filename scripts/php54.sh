#!/bin/sh

# Taken from http://webtatic.com/packages/php54/

echo ">>> Installing PHP 5.4"

sudo rpm -Uvh http://mirror.webtatic.com/yum/el6/latest.rpm
sudo yum install -y php54w php54w-common php54w-fpm php54w-pecl-xdebug

# xdebug Config
cat >> $(find /etc/php.d -name xdebug.ini) << EOF
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

# PHP Error Reporting Config
sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php.ini
sed -i "s/html_errors = .*/display_errors = On/" /etc/php.ini

# Starting PHP-FPM
sudo /etc/init.d/php-fpm start

sudo chkconfig --levels 235 php-fpm on