#!/bin/bash

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

# Install ImageMagick
sudo apt-get -y install imagemagick libmagick9-dev

echo "###############################################"
echo "     imagemagick installation is complete!     "
echo "###############################################"