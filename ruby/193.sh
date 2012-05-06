#!/bin/bash
#
# This script was originally from https://github.com/joshfng/railsready
#

RUBY_VER="1.9.3-p194"
RUBYGEMS_VER="1.8.24"

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby ${RUBY_VER} and Rubygems ${RUBYGEMS_VER}"

# Update the system
sudo apt-get update
sudo apt-get upgrade -y

# Install wget & curl before continuing
sudo apt-get -y install wget curl

# Install build tools
sudo apt-get -y install wget curl build-essential bison openssl zlib1g zlib1g-dev libxslt1.1 libssl-dev \
libxslt1-dev libxml2 libffi-dev libyaml-dev libxslt-dev autoconf libc6-dev libreadline6-dev zlib1g-dev \
libffi-dev libffi-ruby

# Install Ruby to /usr/local
curl http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-${RUBY_VER}.tar.gz --O /tmp/ruby-${RUBY_VER}.tar.gz
cd /tmp && tar -xzf /tmp/ruby-${RUBY_VER}.tar.gz
cd ruby-${RUBY_VER}
./configure --prefix=/usr/local
make
sudo make install
cd /tmp

# Install Rubygems
curl http://production.cf.rubygems.org/rubygems/rubygems-${RUBYGEMS_VER}.tgz --O /tmp/rubygems-${RUBYGEMS_VER}.tgz
cd /tmp && tar -xzf /tmp/rubygems-${RUBYGEMS_VER}.tgz
cd rubygems-${RUBYGEMS_VER}
sudo /usr/local/bin/ruby setup.rb
cd /tmp

# Clean up downloaded files in /tmp
sudo rm -rf /tmp/rubygems-${RUBYGEMS_VER}*
sudo rm -rf /tmp/ruby-${RUBY_VER}*

echo "###############################################"
echo "           Installation is complete!           "
echo "###############################################"