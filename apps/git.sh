#!/bin/bash

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

# Install git-core
sudo apt-get -y install git-core


echo "###############################################"
echo "         git installation is complete!         "
echo "###############################################"

