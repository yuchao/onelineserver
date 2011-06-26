###Get a full Ruby on Rails and PHP stack up in one line :)

Run this on a fresh install. Tested on Ubuntu server 10.04 lts && 10.10

###To run:
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/railsready.sh >> railsready.sh && chmod a+x railsready.sh && ./railsready.sh
  * The script will ask if you want to build Ruby from source or install RVM
  * If you want to watch the magic happen run "tail -f ~/railsready/install.log"

##What this gives you:

  * An updated system
  * Apache 2
  * PHP 5.3.5
  * MySQL server 5.5
  * Ruby 1.9.2p180 (installed to /usr/local/bin/ruby) or RVM running 1.9.2p180
  * OpenSSH server
  * Imagemagick
  * libs needed to run Rails (sqlite, mysql, etc)
  * Bundler, Passenger, and Rails gems
  * Git

Please note: If you are running on a super slow connection your sudo session may timeout and you'll have to enter your password again. If you're running this on an EC2 or RS instance it shouldn't be problem.

I use this to setup VMs all the time but I'm sure this script can be improved. It's meant to serve as quick start to get all the dependencies, Ruby, and Rails on a system with no interaction. Basically it's just running all the apt-get commands for you (aside from building Ruby). I'll update the commands and ruby versions as they change.