###Get a full Ruby on Rails and PHP stack up in one line :)

Run this on a fresh install. Tested on Ubuntu server 10.04 lts && 10.10 && 11.10

###Ruby 1.9.2
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/railsready-ruby192.sh >> railsready-ruby192.sh && chmod a+x railsready-ruby192.sh && ./railsready-ruby192.sh
* This will install Ruby from source
* If you want to watch the magic happen run "tail -f ~/railsready-ruby192/install.log"

###Ruby 1.9.3
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/railsready-ruby193.sh >> railsready-ruby193.sh && chmod a+x railsready-ruby193.sh && ./railsready-ruby193.sh
* This will install Ruby from source
* If you want to watch the magic happen run "tail -f ~/railsready-ruby193/install.log"


###Ruby 1.9.2 RVM
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/railsready-ruby192-rvm.sh >> railsready-ruby192-rvm.sh && chmod a+x railsready-ruby192-rvm.sh && ./railsready-ruby192-rvm.sh
* This will install Ruby using RVM
* If you want to watch the magic happen run "tail -f ~/railsready-ruby192-rvm/install.log"

###Ruby 1.9.3 RVM
    sudo apt-get -y install curl && curl https://raw.github.com/deanperry/onelineserver/master/railsready-ruby193-rvm.sh >> railsready-ruby193-rvm.sh && chmod a+x railsready-ruby193-rvm.sh && ./railsready-ruby193-rvm.sh
* This will install Ruby using RVM
* If you want to watch the magic happen run "tail -f ~/railsready-ruby193-rvm/install.log"


##What this gives you:

  * An updated system
  * Apache 2
  * PHP 5.3.5
  * MySQL server 5.5
  * Ruby 1.9.2p290 or Ruby 1.9.3p0 or RVM running 1.9.2p290 or 1.9.3p0
  * OpenSSH server
  * Imagemagick
  * libs needed to run Rails (sqlite, mysql, etc)
  * Bundler, Passenger, and Rails gems
  * Git

Please note: If you are running on a super slow connection your sudo session may timeout and you'll have to enter your password again. If you're running this on an EC2 or RS instance it shouldn't be problem.

I use this to setup VMs all the time but I'm sure this script can be improved. It's meant to serve as quick start to get all the dependencies, Ruby, and Rails on a system with no interaction. Basically it's just running all the apt-get commands for you (aside from building Ruby). I'll update the commands and ruby versions as they change.