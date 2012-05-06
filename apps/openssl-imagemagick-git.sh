#!/bin/bash

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

# Install OpenSSL
sudo apt-get -y install libssl-dev libopenssl-ruby libcurl4-openssl-dev

# Install ImageMagick
sudo apt-get -y install imagemagick libmagick9-dev

# Install git-core
sudo apt-get -y install git-core


echo "###############################################"
echo "       openssl installation is complete!       "
echo "     imagemagick installation is complete!     "
echo "         git installation is complete!         "
echo "###############################################"