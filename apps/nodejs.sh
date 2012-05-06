#!/bin/bash

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

# Install NodeJS
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get -y update
sudo apt-get -y install nodejs

echo "###############################################"
echo "       nodejs installation is complete!        "
echo "###############################################"