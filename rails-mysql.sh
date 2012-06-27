#!/bin/bash

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby 1.9.3, Rubygems, nginx, OpenSSL, ImageMagick, Git, nodejs & MySQL"

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Run the Ruby 1.9.3 & Rubygems installer
curl -L http://qyk.in/0mc | bash

# Run the nginx installer
curl -L http://qyk.in/h4u | bash

# Run the OpenSSL installer
curl -L http://qyk.in/mtr | bash

# Run the ImageMagick installer
curl -L http://qyk.in/e3i | bash

# Run the git installer
curl -L http://qyk.in/yhv | bash

# Run the nodejs installer
curl -L http://qyk.in/98k | bash

# Run the MySQL installer
curl -L http://qyk.in/68t | bash

echo "###############################################"
echo "###############################################"
echo "           Installation is complete!           "
echo "###############################################"
echo "###############################################"