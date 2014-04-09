#!/bin/sh

[[ -z "$1" ]] && { echo "!!! Ruby version not set. Check the Vagrant file."; exit 1; }

# Taken from http://rvm.io/rvm/install

\curl -sSL https://get.rvm.io | bash -s stable --ruby

source /home/vagrant/.bash_profile
source /home/vagrant/.rvm/scripts/rvm

# login as a shell (this fixes an issue with `rvm` not being a function)
/bin/bash --login

# download specified version of ruby
rvm install $1
rvm use $1 --default