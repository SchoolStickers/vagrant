#!/bin/sh

echo ">>> Installing PhantomJS 1.9.2"

cd /usr/src
wget https://phantomjs.googlecode.com/files/phantomjs-1.9.2-linux-x86_64.tar.bz2
tar xvjf phantomjs-1.9.2-linux-x86_64.tar.bz2
cp phantomjs-1.9.2-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
ln -s /usr/local/bin/phantomjs /usr/bin/phantomjs

# We need to add our custom worker to the supervisord.conf if its not present already
if [ -x /usr/bin/supervisord ]; then
	echo "... Updating supervisord.conf"
	if ! grep "phantom_worker" -L /etc/supervisord.conf >/dev/null; then
		cat >> /etc/supervisord.conf << EOF
[program:phantom_worker]
directory = /vagrant/schoolstickers.com/public_html/var/customtool/queue/
command = php /vagrant/schoolstickers.com/public_html/var/customtool/queue/phantom_worker.php
autostart = true
autorestart = true
logfile = /vagrant/schoolstickers.com/public_html/var/customtool/queue/log/phantom_worker.log
log_stdout = true
log_stderr = true
user = vagrant
EOF
	fi

	# Restart supervisord
	/etc/init.d/supervisord restart
fi