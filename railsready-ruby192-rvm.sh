#!/bin/bash
#
# Author: Josh Frye <joshfng>
# Licence: MIT
#
# Contributions from: Wayne E. Seguin <wayneeseguin@gmail.com>
# Apache, PHP, MySQL and SSH supported by: Dan Harper <danharper>
# Added some extra stuff like the Passenger Apache2 Module pre-reqs  <deanperry>
#

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby 1.9.2p290 along with the latest version of Apache, PHP, MySQL Server, Imagemagick, Git, Rails, Bundler and Passenger "

echo "Creating install dir..."
cd && mkdir -p railsready-ruby192-rvm/src && cd railsready-ruby192-rvm && touch install.log
echo "done.."

# Update the system before going any further
echo "Updating system..."
sudo apt-get update >> install.log && sudo apt-get -y upgrade >> install.log
echo "done.."

# Install build tools
echo "Installing build tools..."
sudo apt-get -y install \
    wget curl build-essential \
    bison openssl zlib1g zlib1g-dev \
    libxslt1.1 libssl-dev libxslt1-dev \
    libxml2 libffi-dev libyaml-dev \
    libxslt-dev autoconf libc6-dev \
    libreadline6-dev zlib1g-dev >> install.log
echo "done..."

echo "Installing SSH server..."
sudo apt-get -y install openssh-client openssh-server >> install.log
echo "done..."

echo "Installing Apache web server..."
sudo apt-get -y install apache2 >> install.log
echo "done..."

echo "Installing PHP..."
sudo apt-get -y install php5 >> install.log
echo "done..."

echo "Installing libs needed for sqlite and mysql..."
sudo apt-get -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient16-dev libmysqlclient16 >> install.log
echo "done..."

echo "Installing MySQL server (you will be prompted for to provide a password for your MySQL root user)"
sudo apt-get -y install mysql-server mysql-client
echo "done..."

echo "Setting up PHP and Apache to work with MySQL..."
sudo apt-get -y install libapache2-mod-auth-mysql php5-mysql >> install.log
echo "done..."

# Install imagemagick
echo "Installing imagemagick (this may take awhile)..."
sudo apt-get -y install imagemagick libmagick9-dev >> install.log
echo "done..."

# Install git-core
echo "Installing git..."
sudo apt-get -y install git-core >> install.log
echo "done..."

# Install prerequisites for Passenger Apache2 Module
echo "Installing prerequisites for the Passenger Apache2 Module"
sudo apt-get install -y libcurl4-openssl-dev apache2-prefork-dev libapr1-dev >> install.log
echo "done..."


echo "Installing RVM the Ruby environment Manager http://rvm.beginrescueend.com/rvm/install/"
curl -O -L http://rvm.beginrescueend.com/releases/rvm-install-head
chmod +x rvm-install-head
"$PWD/rvm-install-head" >> ~/railsready-ruby192-rvm/install.log
[[ -f rvm-install-head ]] && rm -f rvm-install-head
echo "Setting up RVM to load with new shells."
echo  '[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # Load RVM into a shell session *as a function*' >> "$HOME/.bashrc"
echo "=> Loading RVM"
source ~/.rvm/scripts/rvm
source ~/.bashrc
echo "Installing Ruby 1.9.2 (this will take awhile)"
echo "More information about installing rubies can be found at http://rvm.beginrescueend.com/rubies/installing/"
rvm install 1.9.2 >> ~/railsready-ruby192-rvm/install.log
echo "Using 1.9.2 and setting it as default for new shells"
echo "More information about Rubies can be found at http://rvm.beginrescueend.com/rubies/default/"
rvm --default use 1.9.2


# Reload bash
echo "Reloading bashrc so ruby and rubygems are available..."
source ~/.bashrc
echo "done..."

echo "Installing Bundler, Passenger and Rails.."
gem install bundler passenger rails --no-ri --no-rdoc >> ~/railsready-ruby192-rvm/install.log
echo "done..."

echo "Installation is complete!"

echo "run source ~/.bashrc or logout and back in to access Ruby"

echo "To setup Passenger with Apache2, run passenger-install-apache2-module"