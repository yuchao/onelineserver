#!/bin/bash
#
# This script was originally from https://github.com/joshfng/railsready
#

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby and Rubygems using the Brightbox repos"

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Install wget & curl before continuing
sudo apt-get -y install wget curl python-software-properties

# Add the brightbox ruby repo
sudo apt-add-repository ppa:brightbox/ruby-ng-experimental
sudo apt-get update

sudo apt-get install ruby1.9.3 rubygems ruby-switch

ruby-switch --list

sudo ruby-switch --set ruby1.9.1

ruby -v

echo "###############################################"
echo "           Installation is complete!           "
echo "###############################################"