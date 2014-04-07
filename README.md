# School Stickers Vagrant Box

This Vagrant box is for use with [School Stickers](http://www.schoolstickers.co.uk/) projects.

While we're happy for the community at large to use it for their own purposes, it is highly opinionated to the requirements of School Stickers, and we'll be unable to provide you with any support for it.

Instead, we recommend you use [Vaprobash](https://github.com/fideloper/Vaprobash), on which this project is based.

## First things first

1. Install [VirtualBox](https://www.virtualbox.org/).
2. Install [Vagrant](http://www.vagrantup.com/).
3. Install [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier) plugin by running `vagrant plugin install vagrant-cachier`.
4. Install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin by running `vagrant plugin install vagrant-vbguest`.

## Using rsync?

As with all things Windows related, this isn't as simple as one might hope. Vagrant 1.5's new Rsync folder syncing does work, but (we ever) there are a few hops to jump though. The following works for me with Vagrant 1.5.1 using git bash/MinGW.

1. Download [cwRsync](https://www.itefix.no/i2/content/cwrsync-free-edition) to your machine and add its directory to your path. [[Source]](http://www.thomasvjames.com/2013/09/vagrant-aws-rsync-on-windows/)
2. Edit `C:\HashiCorp\Vagrant\embedded\gems\gems\vagrant-1.5.1\plugins\synced_folders\rsync\helper.rb` and add `hostpath = "/cygdrive" + hostpath` to line 74. [[Source]](https://github.com/mitchellh/vagrant/issues/3230#issuecomment-37757086)

## Using in your project

1. Copy `Vagrantfile` from this repo into the root of your project.
2. Ensure the following files/folders exist in the root of your project:
 * `public_html/` served by nginx.
 * `log/` used for log files.
 * `import.sql` SQL dump for any databases you need *(optional)*.
 * `vhosts/*` any custom vhosts you want your box to use *(optional)*.
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