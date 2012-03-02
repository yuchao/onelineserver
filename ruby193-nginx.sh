#!/bin/bash
#
# This script was originally from https://github.com/joshfng/railsready
# It has been modified by deanperry for his own use and for using with Vagrant as a provisioner
#

TIMEZONE="Europe/London"
SOURCES="https://raw.github.com/gist/1745922"
# GB - https://raw.github.com/gist/1745922
RUBY_VER="1.9.3-p125"




shopt -s extglob
set -e

# Check if the user has sudo privileges.
sudo -v >/dev/null 2>&1 || { echo $(whoami) has no sudo privileges ; exit 1; }

echo "This script installs Ruby ${RUBY_VER} along with the latest version of Apache, PHP, MySQL Server, Imagemagick, Git, Rails, Bundler and Passenger"

# Set localtime as Europe/London
# /etc/timezone is chmoded as 777 because of
# access denied errors it is only a hack
sudo chmod 777 /etc/timezone && sudo echo $TIMEZONE > /etc/timezone                     
sudo cp /usr/share/zoneinfo/${TIMEZONE} /etc/localtime

# Install wget & curl before continuing
sudo apt-get -y install wget curl

# Download GB Ubuntu 11.10.3 sources.list to /etc/apt
curl ${SOURCES} --O /etc/apt/sources.list

# Update the system before going any further
sudo aptitude update
sudo aptitude hold grub-pc
sudo aptitude full-upgrade -y

# Install build tools
sudo apt-get -y install wget curl build-essential bison openssl zlib1g zlib1g-dev libxslt1.1 libssl-dev \
libxslt1-dev libxml2 libffi-dev libyaml-dev libxslt-dev autoconf libc6-dev libreadline6-dev zlib1g-dev \
libffi-dev libffi-ruby

# Install python-software-properties
sudo apt-get -y install python-software-properties
nginx=stable # use nginx=development for latest development version
sudo add-apt-repository ppa:nginx/$nginx
sudo apt-get update 
sudo apt-get -y install nginx 

# Start nginx
sudo /etc/init.d/nginx start


# Install libs needed for sqlite and mysql
sudo apt-get -y install libsqlite3-0 sqlite3 libsqlite3-dev libmysqlclient16-dev libmysqlclient16

# Install MySQL server - default password is Passw0rd
sudo chmod 777 -R /var/cache/debconf
echo "mysql-server-5.1 mysql-server/root_password password Passw0rd" | debconf-set-selections
echo "mysql-server-5.1 mysql-server/root_password_again password Passw0rd" | debconf-set-selections
sudo apt-get -y install mysql-server mysql-client

# Install OpenSSL
sudo apt-get -y install libssl-dev libopenssl-ruby libcurl4-openssl-dev

# Install imagemagick
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

# Install Rubygems 1.8.15
curl http://production.cf.rubygems.org/rubygems/rubygems-1.8.15.tgz --O /tmp/rubygems-1.8.15.tgz
cd /tmp && tar -xzf /tmp/rubygems-1.8.15.tgz
cd rubygems-1.8.15
sudo /usr/local/bin/ruby setup.rb
cd /tmp

# Reload bashrc
source ~/.bashrc

# Install Bundler
sudo /usr/local/bin/gem install bundler --no-ri --no-rdoc
# sudo /usr/local/bin/gem install passenger -v 3.0.11 --no-ri --no-rdoc


# Copy default nginx site and add new default nginx site
# From http://ariejan.net/2011/09/14/lighting-fast-zero-downtime-deployments-with-git-capistrano-nginx-and-unicorn
sudo mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.orig
sudo cat > /etc/nginx/sites-available/default << EOF
upstream my_site {
  # fail_timeout=0 means we always retry an upstream even if it failed
  # to return a good HTTP response (in case the Unicorn master nukes a
  # single worker for timing out).

  # for UNIX domain socket setups:
  server unix:/tmp/my_site.socket fail_timeout=0;
}

server {
    # if you're running multiple servers, instead of "default" you should
    # put your main domain name here
    listen 80 default;

    # you could put a list of other domain names this application answers
    server_name my_site.example.com;

    root /home/deployer/apps/my_site/current/public;
    access_log /var/log/nginx/my_site_access.log;
    rewrite_log on;

    location / {
        #all requests are sent to the UNIX socket
        proxy_pass  http://my_site;
        proxy_redirect     off;

        proxy_set_header   Host             $host;
        proxy_set_header   X-Real-IP        $remote_addr;
        proxy_set_header   X-Forwarded-For  $proxy_add_x_forwarded_for;

        client_max_body_size       10m;
        client_body_buffer_size    128k;

        proxy_connect_timeout      90;
        proxy_send_timeout         90;
        proxy_read_timeout         90;

        proxy_buffer_size          4k;
        proxy_buffers              4 32k;
        proxy_busy_buffers_size    64k;
        proxy_temp_file_write_size 64k;
    }

    # if the request is for a static resource, nginx should serve it directly
    # and add a far future expires header to it, making the browser
    # cache the resource and navigate faster over the website
    # this probably needs some work with Rails 3.1's asset pipe_line
    location ~ ^/(images|javascripts|stylesheets|system)/  {
      root /home/deployer/apps/my_site/current/public;
      expires max;
      break;
    }
}
EOF

# Update nginx.conf file with optimized defaults
# From http://ariejan.net/2011/09/14/lighting-fast-zero-downtime-deployments-with-git-capistrano-nginx-and-unicorn
sudo cat > /etc/nginx/nginx.conf  << NGINX_CONF
user deploy www-data;

# Change this depending on your hardware
worker_processes 4;
pid /var/run/nginx.pid;

events {
    worker_connections 1024;
    multi_accept on;
}

http {
    sendfile on;
    tcp_nopush on;
    tcp_nodelay off;
    # server_tokens off;

    # server_names_hash_bucket_size 64;
    # server_name_in_redirect off;

    include /etc/nginx/mime.types;
    default_type application/octet-stream;

    access_log /var/log/nginx/access.log;
    error_log /var/log/nginx/error.log;

    gzip on;
    gzip_disable "msie6";

    # gzip_vary on;
    gzip_proxied any;
    gzip_min_length 500;
    # gzip_comp_level 6;
    # gzip_buffers 16 8k;
    # gzip_http_version 1.1;
    gzip_types text/plain text/css application/json application/x-javascript text/xml application/xml application/xml+rss text/javascript;

    ##
    # Virtual Host Configs
    ##

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}
NGINX_CONF



# # Install and setup the Apache Passenger Module
# yes '' | sudo /usr/local/bin/passenger-install-apache2-module
# 
# # Add the Passenger config to /etc/apache2/httpd.conf
# sudo cat > /etc/apache2/httpd.conf << HTTPD_CONF
# LoadModule passenger_module /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11/ext/apache2/mod_passenger.so
# PassengerRoot /usr/local/lib/ruby/gems/1.9.1/gems/passenger-3.0.11
# PassengerRuby /usr/local/bin/ruby
# HTTPD_CONF

# Link mysqld.sock to /tmp/mysql.sock
ln -s /var/run/mysqld/mysqld.sock /tmp/mysql.sock

# # Restart Apache
# sudo /etc/init.d/apache2 restart



# Clean up downloaded files in /tmp
sudo rm -rf /tmp/yaml-0.1.4*
sudo rm -rf /tmp/rubygems-1.8.15*
sudo rm -rf /tmp/ruby-${RUBY_VER}*

echo "Installation is complete!"