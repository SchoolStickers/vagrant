#!/bin/sh

if [ -d /vagrant/schoolstickers.com/public_html/var/customtool/fonts ]; then
	echo ">>> Installing Customtool Fonts"
	mkdir /usr/share/fonts/TTF
	cp -f /vagrant/schoolstickers.com/public_html/var/customtool/fonts/*.ttf /usr/share/fonts/TTF/
	fc-cache -f -v
fi

# To allow people to use chinese chars..
echo ">>> Enabling Chinese font support"
yum groupinstall -y "Chinese Support"