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

# Copy mysql-clients.cnf from files dir if it exists
if [ -f /vagrant/files/my.cnf.d/mysql-clients.cnf ]; then
	echo " * Copying MySQL config files"
	cp -f /vagrant/files/my.cnf.d/mysql-clients.cnf /etc/my.cnf.d/mysql-clients.cnf
fi

# Starting MariaDB
sudo /etc/init.d/mysql restart

sudo chkconfig mysql on

# Import sql files that have not been flagged as imported
# To reimport a db file remove the .ran
if [ -d "/vagrant/db" ]; then
	for d in "/vagrant/db"; do
		for f in $d/*; do
			cd $f
			if ! mysql -uroot ${PWD##*/} >/dev/null 2>&1 </dev/null; then
			  echo " * Creating new database ${PWD##*/}"
			  mysql -uroot -e "CREATE DATABASE \`${PWD##*/}\` CHARACTER SET utf8 COLLATE utf8_general_ci;"
			fi
			for s in $f/*.sql; do	
				if [ ! -f $s.ran ]; then
					echo " * Importing DB data from" $s
					mysql -uroot ${PWD##*/} < $s;
					touch $s.ran
				else
					echo " * $s has already been imported."
				fi
			done
		done
	done
fi





if [ -f /vagrant/import.sql ]; then
	echo ">>> Importing your database"
    mysql -u root < $FILE
fi