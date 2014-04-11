# School Stickers Vagrant Box

This Vagrant box is for use with [School Stickers](http://www.schoolstickers.co.uk/) projects.

While we're happy for the community at large to use it for their own purposes, it is highly opinionated to the requirements of School Stickers, and we'll be unable to provide you with any support for it.

Instead, we recommend you use [Vaprobash](https://github.com/fideloper/Vaprobash), on which this project is based.

## First things first

1. Install [VirtualBox](https://www.virtualbox.org/).
2. Install [Vagrant](http://www.vagrantup.com/).
3. Install [vagrant-cachier](http://fgrehm.viewdocs.io/vagrant-cachier) plugin by running `vagrant plugin install vagrant-cachier`.
4. Install [vagrant-vbguest](https://github.com/dotless-de/vagrant-vbguest) plugin by running `vagrant plugin install vagrant-vbguest`.

## Using [rsync](http://docs.vagrantup.com/v2/synced-folders/rsync.html)?

As with all things Windows related, this isn't as simple as one might hope. Vagrant 1.5's new Rsync folder syncing does work, but (we ever) there are a few hops to jump though. The following works for me with Vagrant 1.5.1 using git bash/MinGW.

1. Download [cwRsync](https://www.itefix.no/i2/content/cwrsync-free-edition) to your machine and add its directory to your path. [[Source]](http://www.thomasvjames.com/2013/09/vagrant-aws-rsync-on-windows/)
2. Edit `C:\HashiCorp\Vagrant\embedded\gems\gems\vagrant-1.5.1\plugins\synced_folders\rsync\helper.rb` and add `hostpath = "/cygdrive" + hostpath` to line 74. [[Source]](https://github.com/mitchellh/vagrant/issues/3230#issuecomment-37757086)

**Don't forget**, if you're using rsync, you need to use the [`vagrant rsync`](http://docs.vagrantup.com/v2/cli/rsync.html) or [`vagrant rsync-auto`](http://docs.vagrantup.com/v2/cli/rsync-auto.html) command to update the files on the VM.

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

* Install MailCatcher.

## Xdebug and fixing the Unidentified Network issue

If you wish to use Xdebug with your own IDE, you might encounter an issue where the IDE isn't able to see the connection from the server. I won't pretend to understand the exact cause of this, rather I'll just say it's related to the Windows firewall rejecting the connection because it's from an Unidentified Network (as shown below).

![](http://i.imgur.com/QZi0W4B.png)

![](http://i.imgur.com/0xLBfVb.png)

Thankfully, fixing the issue is easy, simply follow these instructions ([borrowed from the internet](http://www.brokenwire.net/bw/Various/120/fix-virtualbox-causes-unidentified-network-on-vista-and-windows-7)):

1. Open regedit.
2. Navigate to `HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}`
3. Browse through the subkeys (named 0000, 0001, etc) until you find any subkeys containing the virtualbox network adapter. You're looking for ones where the “DriverDesc” key has “VirtualBox Host-Only Ethernet Adapter” as a value.
4. Add a new DWORD (32) value with a name of `*NdisDeviceType` (don't forget the *), and set it's value to `1`.
 * ![](http://i.imgur.com/O5Ur12p.png)
6. Disable/re-enable all the network adaptors you've just edited (or simply reboot)