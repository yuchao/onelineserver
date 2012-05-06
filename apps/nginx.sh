#!/bin/bash

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

# Install nginx
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update 
sudo apt-get -y install nginx 

# Start nginx
sudo /etc/init.d/nginx start

echo "###############################################"
echo "       nginx installation is complete!         "
echo "###############################################"