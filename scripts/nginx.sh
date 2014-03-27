#!/bin/sh

echo ">>> Installing Nginx"

[[ -z "$1" ]] && { echo "!!! IP address not set. Check the Vagrant file."; exit 1; }

# Adding Yum repo
cat > /etc/yum.repos.d/nginx.repo << EOF
[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/6/x86_64/
gpgcheck=0
enabled=1
EOF

# Installing Nginx
sudo yum install -y nginx

echo ">>> Configuring Nginx"

# Configure Nginx
# Note the .xip.io IP address $1 variable
# is not escaped
cat > /etc/nginx/conf.d/default.conf << EOF
server {
    listen 80;

    root /vagrant/public_html;
    index index.html index.htm index.php app.php app_dev.php;

    # Make site accessible from http://set-ip-address.xip.io
    server_name $1.xip.io;

    access_log /vagrant/logs/access.log;
    error_log  /vagrant/logs/error.log error;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /app.php?\$query_string /index.php?\$query_string;
    }

    location = /favicon.ico { log_not_found off; access_log off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    # pass the PHP scripts to php5-fpm
    # Note: \.php$ is susceptible to file upload attacks
    # Consider using: "location ~ ^/(index|app|app_dev|config)\.php(/|$) {"
    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # With php5-fpm:
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param LARA_ENV local; # Environment variable for Laravel
        fastcgi_param HTTPS off;
    }

    # Deny .htaccess file access
    location ~ /\.ht {
        deny all;
    }
}

server {
    listen 443;

    ssl on;
    ssl_certificate     /etc/ssl/xip.io/xip.io.crt;
    ssl_certificate_key /etc/ssl/xip.io/xip.io.key;

    root /vagrant/public_html;
    index index.html index.htm index.php app.php app_dev.php;

    # Make site accessible from http://set-ip-address.xip.io
    server_name $1.xip.io;

    access_log /vagrant/logs/access.log;
    error_log  /vagrant/logs/error.log error;

    charset utf-8;

    location / {
        try_files \$uri \$uri/ /app.php?\$query_string /index.php?\$query_string;
    }

    location = /favicon.ico { log_not_found off; access_log off; }
    location = /robots.txt  { access_log off; log_not_found off; }

    error_page 404 /index.php;

    # pass the PHP scripts to php5-fpm
    # Note: \.php$ is susceptible to file upload attacks
    # Consider using: "location ~ ^/(index|app|app_dev|config)\.php(/|$) {"
    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        # With php5-fpm:
        fastcgi_pass 127.0.0.1:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;
        fastcgi_param LARA_ENV local; # Environment variable for Laravel
        fastcgi_param HTTPS on;
    }

    # Deny .htaccess file access
    location ~ /\.ht {
        deny all;
    }
}
EOF

# Starting Nginx
sudo /etc/init.d/nginx start
sudo /etc/init.d/php-fpm restart

sudo chkconfig --levels 235 nginx on