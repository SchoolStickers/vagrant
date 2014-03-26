# -*- mode: ruby -*-
# vi: set ft=ruby :

# Config Github Settings
github_username = "SchoolStickers"
github_repo     = "vagrant"
github_tag      = "1"
# github_path    = "https://raw.github.com/#{github_username}/#{github_repo}/#{github_branch}/"
github_path     = ""

# Server Configuration

# Set a local private network IP address.
# See http://en.wikipedia.org/wiki/Private_network for explanation
# You can use the following IP ranges:
#   10.0.0.1    - 10.255.255.254
#   172.16.0.1  - 172.31.255.254
#   192.168.0.1 - 192.168.255.254
server_ip             = "192.168.33.10"
server_memory         = "1024" # MB
server_timezone       = "UTC"

# Database Configuration
mariadb_version       = "5.1"
mariadb_root_password = "root"

# Languages and Packages
ruby_version          = "latest" # Choose what ruby version should be installed (will also be the default version)
ruby_gems             = [        # List any Ruby Gems that you want to install
  #"jekyll",
  #"sass",
  #"compass",
  #"bundler",
]
php_version           = "5.4" # Options: latest|previous|distributed   For 12.04. latest=5.5, previous=5.4, distributed=5.3
composer_packages     = [        # List any global Composer packages that you want to install
  #"phpunit/phpunit:4.0.*",
  #"codeception/codeception=*",
  #"phpspec/phpspec:2.0.*@dev",
]
nodejs_version        = "latest"   # By default "latest" will equal the latest stable version
nodejs_packages       = [          # List any global NodeJS packages that you want to install
  #"grunt-cli",
  #"gulp",
  #"bower",
  #"yo",
]

# Lets do this
Vagrant.configure(2) do |config|

  # Which box are we using?
  config.vm.box = "centos-65-x64-virtualbox-nocm"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-65-x64-virtualbox-nocm.box"

  # Network settings
  config.vm.hostname = "vagrant"
  config.vm.network "private_network", ip: server_ip

  # Port forwarding
  config.vm.network "forwarded_port", guest: 35729, host: 35729 #LiveReload

  # Folder sharing
  config.vm.synced_folder ".", "/vagrant"

  # Vitualbox settings
  config.vm.provider "virtualbox" do |vb|

    # Set memory
    vb.customize ["modifyvm", :id, "--memory", server_memory]

    # Set the timesync threshold to 10 seconds, instead of the default 20 minutes.
    # If the clock gets more than 15 minutes out of sync (due to your laptop going
    # to sleep for instance, then some 3rd party services will reject requests.
    vb.customize ["guestproperty", "set", :id, "/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold", 10000]

  end

  ####
  # Base Items
  ##########

  # Provision Base Packages
  config.vm.provision "shell", path: "#{github_path}scripts/base.sh"

  # Provision PHP
  config.vm.provision "shell", path: "#{github_path}scripts/php54.sh"

  # Provision MariaDB
  config.vm.provision "shell", path: "#{github_path}scripts/mariadb55.sh"

end