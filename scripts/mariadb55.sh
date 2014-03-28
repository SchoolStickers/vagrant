#!/bin/sh

# Taken from https://mariadb.com/kb/en/installing-mariadb-with-yum/

echo ">>> Installing MariaDB"

# Adding Yum repo
cat > /etc/yum.repos.d/MariaDB.repo << EOF
# MariaDB 5.5 CentOS repository list - created 2014-03-26 10:34 UTC
# http://mariadb.org/mariadb/repositories/
[mariadb]
name = MariaDB
baseurl = http://yum.mariadb.org/5.5/centos6-amd64
gpgkey=https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
gpgcheck=1
EOF

# Installing MariaDB
sudo yum install -y MariaDB-server MariaDB-client

# Starting MariaDB
sudo /etc/init.d/mysql start

sudo chkconfig --levels 235 mysql on

# Import your sql-dump, if one exists
FILE="/vagrant/sql/import.sql"
if [ -f $FILE ]; then
	echo ">>> Importing your database"
    mysql -u root < $FILE
fi