#!/bin/bash

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby ${RUBY_VER} and Rubygems ${RUBYGEMS_VER}"

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Run the Ruby 1.9.3 & Rubygems installer
curl -L http://qyk.in/0mc | bash

