# School Stickers Vagrant Box

This Vagrant box is for use with [School Stickers](http://www.schoolstickers.co.uk/) projects.

While we're happy for the community at large to use it for their own purposes, it is highly opinionated to the requirements of School Stickers, and we'll be unable to provide you with any support for it.

Instead, we recommend you use [Vaprobash](https://github.com/fideloper/Vaprobash), on which this project is based.

## First things first
1. Install [VirtualBox](https://www.virtualbox.org/)
2. Install [Vagrant](http://www.vagrantup.com/)
3. Install [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier) plugin by running `vagrant plugin install vagrant-cachier`

## Using in your project
1. Copy `Vagrantfile` from this repo into the root of your project
2. Ensure the following files/folders exist in the root of your project:
 * `public_html/` served by nginx
 * `log/` used for log files
 * `sql/import.sql` SQL dump for any databases you need *(optional)*
3. Run `vagrant up` from the root of your project
4. Go have a coffee while it's provisioning.