# School Stickers Vagrant Box

This Vagrant box is for use with [School Stickers](http://www.schoolstickers.co.uk/) projects.

While we're happy for the community at large to use it for their own purposes, it is highly opinionated to the requirements of School Stickers, and we'll be unable to provide you with any support for it.

Instead, we recommend you use [Vaprobash](https://github.com/fideloper/Vaprobash), on which this project is based.

## First things first
1. Install [VirtualBox](https://www.virtualbox.org/).
2. Install [Vagrant](http://www.vagrantup.com/).
3. Install [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier) plugin by running `vagrant plugin install vagrant-cachier`.

## Using in your project
1. Copy `Vagrantfile` from this repo into the root of your project.
2. Ensure the following files/folders exist in the root of your project:
 * `public_html/` served by nginx.
 * `log/` used for log files.
 * `sql/import.sql` SQL dump for any databases you need *(optional)*.
3. Run `vagrant up` from the root of your project.
4. Go have a coffee while it's provisioning.

## Settings
* Base:
 * IP address: `192.168.33.10`.
 * URL: [`192.168.33.10.xip.io`](http://192.168.33.10.xip.io/)
* Nginx:
 * HTTP port: `5580`.
 * HTTPS port: `443` .
* Varnish:
 * HTTP port: `80`.
 * Forwarding to: `5580`.
* MySQL/MariaDB:
 * Username: `root`.
 * Password: *no password*.
 * Database: *The import.sql script needs to create the required databases*.

## Todo
* Allow config of the above settings via the `Vagrantfile`. 
* Install MailCatcher.
* Provide the ability to set-up multiple vhosts.
* Fix RVM (RVM installs fine, and downloads Ruby 2.1, but doesn't `use` 2.1)