#!/bin/sh

[[ -z "$1" ]] && { echo "!!! Ruby version not set. Check the Vagrant file."; exit 1; }

# https://github.com/sstephenson/ruby-build/wiki#suggested-build-environment
sudo yum install -y gcc-c++ glibc-headers openssl-devel readline libyaml-devel readline-devel zlib zlib-devel

# https://github.com/sstephenson/rbenv#basic-github-checkout
git clone https://github.com/sstephenson/rbenv.git $HOME/.rbenv

# https://github.com/sstephenson/ruby-build#installation
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

echo -e '\nexport PATH="$HOME/.rbenv/bin:$PATH"\n' >> $HOME/.bash_profile
echo -e '\neval "$(rbenv init -)"\n' >> $HOME/.bash_profile

. /home/vagrant/.bash_profile

rbenv install $1
rbenv global $1