#!/bin/sh

# Taken from http://rvm.io/rvm/install

\curl -sSL https://get.rvm.io | bash -s stable --ruby

source /home/vagrant/.bash_profile
source /home/vagrant/.rvm/scripts/rvm

/bin/bash --login
rvm install 2.1
rvm use 2.1