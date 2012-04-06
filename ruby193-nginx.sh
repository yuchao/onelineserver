#!/bin/bash
#
# This script was originally from https://github.com/joshfng/railsready
#

MYSQL_ROOT_PASS="Passw0rd"
RUBY_VER="1.9.3-p125"
RUBYGEMS_VER="1.8.21"

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby ${RUBY_VER} along with the latest version of Nginx, MySQL Server, ImageMagick, Git, Rails and Bundler"

# Install wget & curl before continuing
sudo apt-get -y install wget curl

# Update the system before going any further
sudo apt-get update
sudo apt-get upgrade -y

# Install build tools
sudo apt-get -y install wget curl build-essential bison openssl zlib1g zlib1g-dev libxslt1.1 libssl-dev libxslt1-dev libxml2 libffi-dev libyaml-dev libxslt-dev autoconf libc6-dev libreadline6-dev zlib1g-dev libffi-dev libffi-ruby

# Install python-software-properties
sudo apt-get -y install python-software-properties

# Install nginx
sudo add-apt-repository ppa:nginx/stable
sudo apt-get update 
sudo apt-get -y install nginx 

# Start nginx
sudo /etc/init.d/nginx start

# Install libs needed for sqlite and mysql
sudo apt-get -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient16-dev libmysqlclient16

# Install MySQL server - default password is set as a variable at the top of this file
sudo chmod 777 -R /var/cache/debconf # Probs not a good idea to chmod this as 777
# Set the MySQL password for some cool silent install stuff
echo "mysql-server-5.1 mysql-server/root_password password ${MYSQL_ROOT_PASS}" | debconf-set-selections
echo "mysql-server-5.1 mysql-server/root_password_again password ${MYSQL_ROOT_PASS}" | debconf-set-selections
sudo apt-get -y install mysql-server mysql-client

# Install OpenSSL
sudo apt-get -y install libssl-dev libopenssl-ruby libcurl4-openssl-dev

# Install ImageMagick
sudo apt-get -y install imagemagick libmagick9-dev

# Install git-core
sudo apt-get -y install git-core

# Install libyaml
curl http://pyyaml.org/download/libyaml/yaml-0.1.4.tar.gz --O /tmp/yaml-0.1.4.tar.gz
cd /tmp && tar -xzf /tmp/yaml-0.1.4.tar.gz
cd yaml-0.1.4
./configure --prefix=/usr/local
make
sudo make install
cd /tmp

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

# Reload bashrc
source ~/.bashrc

# Install Bundler
sudo /usr/local/bin/gem install bundler --no-ri --no-rdoc

# Link mysqld.sock to /tmp/mysql.sock
ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock



# Clean up downloaded files in /tmp
sudo rm -rf /tmp/yaml-0.1.4*
sudo rm -rf /tmp/rubygems-${RUBYGEMS_VER}*
sudo rm -rf /tmp/ruby-${RUBY_VER}*

echo "###############################################"
echo "           Installation is complete!           "
echo "   MySQL root password is ${MYSQL_ROOT_PASS}   "
echo "###############################################"