#!/bin/sh

echo ">>> Finalising Install, not long now..."

# Updating locate database
sudo updatedb

# Copy dotfiles
wget -P /home/vagrant https://raw.githubusercontent.com/SchoolStickers/vagrant/master/dotfiles/.gitconfig
wget -P /home/vagrant https://raw.githubusercontent.com/SchoolStickers/vagrant/master/dotfiles/.bash_aliases

# Add support for bash_completion
printf "\n\n# Add support for bash_completion \n. /etc/bash_completion.d/git" >> /home/vagrant/.bash_profile

# Add .bash_aliases to .bash_profile
printf "\n\n# source .bash_aliases \n. .bash_aliases" >> /home/vagrant/.bash_profile

# Tell everyone the job is finished
cat << EOF



 _____                     _      _              ___
|  |  |___ ___ ___ ___ ___| |_   | |_ ___ _ _   |  _|___ ___
|  |  | .'| . |  _| .'|   |  _|  | . | . |_'_|  |  _| . |  _|
 \___/|__,|_  |_| |__,|_|_|_|    |___|___|_,_|  |_| |___|_|
          |___|
 _____     _           _    _____ _   _     _
|   __|___| |_ ___ ___| |  |   __| |_|_|___| |_ ___ ___ ___
|__   |  _|   | . | . | |  |__   |  _| |  _| '_| -_|  _|_ -|
|_____|___|_|_|___|___|_|  |_____|_| |_|___|_,_|___|_| |___|
                                          __
 _                          _     _      |  |
|_|___    ___ ___ _____ ___| |___| |_ ___|  |
| |_ -|  |  _| . |     | . | | -_|  _| -_|__|
|_|___|  |___|___|_|_|_|  _|_|___|_| |___|__| (now, do some work!)



EOF