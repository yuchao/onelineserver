#One Line Server

Run this on a fresh install. Tested on Ubuntu server 10.04 lts && 10.10 && 11.10

This script needs to be run under an account with `sudo` privileges because it does stuff like changing the `/etc/apt/sources.list` to the GB version and fully updates the server. It also sets the Timezone as `Europe/London`

###Ruby 1.9.2
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/ruby192.sh >> ruby192.sh && chmod a+x ruby192.sh && sudo ./ruby192.sh
* This will install Ruby from source

###Ruby 1.9.3
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/ruby193.sh >> ruby193.sh && chmod a+x ruby193.sh && sudo ./ruby193.sh
* This will install Ruby from source

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
  * Passenger installed and setup
  * Apache default site setup to `/var/www/`
  
  
This script was originally by [joshfng](https://github.com/joshfng/railsready), modified by [danharper](https://github.com/danharper/onelineserver) and modified (complete rewrite) by me! :)