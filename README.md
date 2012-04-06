#One Line Server

Run this on a fresh install. Tested on Ubuntu server 10.04 LTS & 10.10 & 11.10

This script needs to be run under an account with `sudo` privileges.

##Ruby 1.9.3 - Nginx
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/ruby193-nginx.sh >> ruby193-nginx.sh && chmod a+x ruby193-nginx.sh && sudo ./ruby193-nginx.sh

##Ruby 1.9.3 - Apache
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/ruby193.sh >> ruby193.sh && chmod a+x ruby193.sh && sudo ./ruby193.sh

##Ruby 1.9.2 - Apache
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/ruby192.sh >> ruby192.sh && chmod a+x ruby192.sh && sudo ./ruby192.sh


##What this gives you:

  * An updated system
  * Apache 2
  * PHP 5.3.5
  * MySQL server 5.5 with the default password of `Passw0rd`
  * Ruby 1.9.2p290 or Ruby 1.9.3p0
  * OpenSSH server
  * Imagemagick
  * libs needed to run Rails (sqlite, mysql, etc)
  * Bundler, Passenger, and Rails gems
  * Git
  * Passenger 3.0.11 installed and setup
  * Apache default site setup to `/var/www/`
  

This script was originally by [joshfng](https://github.com/joshfng/railsready), modified by [danharper](https://github.com/danharper/onelineserver) and modified (complete rewrite) by me! :)