#!/bin/bash

MYSQL_ROOT_PASS="Passw0rd"

shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }


# Install libs needed for sqlite and mysql
sudo apt-get -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient16-dev libmysqlclient16

# Install MySQL server - default password is set as a variable at the top of this file
sudo chmod 777 -R /var/cache/debconf # Probs not a good idea to chmod this as 777
# Set the MySQL password for some cool silent install stuff
echo "mysql-server-5.1 mysql-server/root_password password ${MYSQL_ROOT_PASS}" | debconf-set-selections
echo "mysql-server-5.1 mysql-server/root_password_again password ${MYSQL_ROOT_PASS}" | debconf-set-selections
sudo apt-get -y install mysql-server mysql-client

# Link mysqld.sock to /tmp/mysql.sock
ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock


echo "###############################################"
echo "       mysql installation is complete!         "
echo "###############################################"
echo "   MySQL root password is ${MYSQL_ROOT_PASS}   "
echo "###############################################"