#!/bin/bash

echo ">>> Installing Mailcatcher"

# install sqlite-devel (required for mailcatcher)
sudo yum install -y sqlite-devel

# source .bash_profile (so gem works)
. /home/vagrant/.bash_profile

# install mailcatcher gem
gem install --no-rdoc --no-ri mailcatcher

WHICH_MAILCATCHER="~/.rbenv/shims/mailcatcher"

# Make it start on boot
sudo echo "@reboot $WHICH_MAILCATCHER --ip=0.0.0.0" >> /etc/crontab
sudo update-rc.d cron defaults

# Make php use it to send mail
sudo echo "sendmail_path = /usr/bin/env $WHICH_MAILCATCHER" >> /etc/php5/mods-available/mailcatcher.ini
sudo php5enmod mailcatcher
sudo service php5-fpm restart

# Start it now
/usr/bin/env $WHICH_MAILCATCHER --ip=0.0.0.0

# Add aliases
if [[ -f "/home/vagrant/.profile" ]]; then
	sudo echo "alias mailcatcher=\"mailcatcher --ip=0.0.0.0\"" >> /home/vagrant/.profile
	. /home/vagrant/.profile
fi