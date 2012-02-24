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

echo "This script installs Ruby 1.9.3p0 along with the latest version of Apache, PHP, MySQL Server, Imagemagick, Git, Rails, Bundler and Passenger "

echo "Creating install dir..."
cd && mkdir -p railsready-ruby193/src && cd railsready-ruby193 && touch install.log
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

echo "Installing MySQL server with the default password of Passw0rd"
sudo chmod 777 -R /var/cache/debconf
echo "mysql-server-5.1 mysql-server/root_password password Passw0rd" | debconf-set-selections
echo "mysql-server-5.1 mysql-server/root_password_again password Passw0rd" | debconf-set-selections
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

# Install Ruby
echo "Downloading Ruby 1.9.3p0"
cd src && wget http://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz
echo "done..."
echo "Extracting Ruby 1.9.3p0"
tar -xzf ruby-1.9.3-p0.tar.gz >> ~/railsready-ruby193/install.log
echo "done..."
echo "Building Ruby 1.9.3p0 (this may take awhile and build output may appear on screen)..."
cd  ruby-1.9.3-p0 && ./configure --prefix=/usr/local >> ~/railsready-ruby193/install.log && make >> ~/railsready-ruby193/install.log && sudo make install >> ~/railsready-ruby193/install.log
echo "done..."

# Reload bash
echo "Reloading bashrc so ruby and rubygems are available..."
source ~/.bashrc
echo "done..."

echo "Installing Bundler, Passenger and Rails.."
sudo gem install bundler passenger rails --no-ri --no-rdoc >> ~/railsready-ruby193/install.log
echo "done..."

echo "Installation is complete!"

echo "run source ~/.bashrc or logout and back in to access Ruby"

echo "To setup Passenger with Apache2, run passenger-install-apache2-module"