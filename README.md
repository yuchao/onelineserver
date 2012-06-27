#One Line Server

Run this on a fresh install. Tested on Ubuntu server 10.04, 10.10, 11.10.

**Currently working on support for Ubuntu 12.04**

This script needs to be run under an account with `sudo` privileges.

`curl` needs to be installed first. - `sudo apt-get install curl`

## Ruby 1.9.3

### Ruby 1.9.3-p194 & Rubygems 1.8.24

	curl -L http://qyk.in/0mc | bash
	
    sudo apt-get -y install curl && curl http://qyk.in/0mc >> 193.sh && chmod a+x 193.sh && sudo ./193.sh

### Ruby 1.9.3 - Nginx
    sudo apt-get -y install curl && curl http://qyk.in/s6k >> 193-n.sh && chmod a+x 193-n.sh && sudo ./193-n.sh

### Ruby 1.9.3 - Apache
    sudo apt-get -y install curl && curl http://qyk.in/e86 >> ruby193.sh && chmod a+x ruby193.sh && sudo ./ruby193.sh

## Ruby 1.9.2

### Ruby 1.9.2-p318 & Rubygems 1.8.21
    sudo apt-get -y install curl && curl http://qyk.in/sfq >> 192.sh && chmod a+x 192.sh && sudo ./192.sh

### Ruby 1.9.2 - Apache
    sudo apt-get -y install curl && curl http://qyk.in/7mi >> ruby192.sh && chmod a+x ruby192.sh && sudo ./ruby192.sh


This script was originally by [joshfng](https://github.com/joshfng/railsready), modified by [danharper](https://github.com/danharper/onelineserver) and modified (complete rewrite) by me! :)


### Ruby 1.9.3 apt-get
Need a quicker installer for Ruby 1.9.3? Use the Brightbox apt-get repos by running this:

	sudo apt-get -y install curl && curl http://qyk.in/h9w >> 193-ag.sh && chmod a+x 193-ag.sh && sudo ./193-ag.sh 
	
	
	
---

## Experimental

Some cool new scripts!

### Apps

OpenSSL, ImageMagick & Git

	curl -L http://qyk.in/e67 | bash
	
nginx

	curl -L http://qyk.in/h4u | bash
	
nodejs

	https://raw.github.com/deanperry/onelineserver/master/apps/nodejs.sh | bash

mysql

	https://raw.github.com/deanperry/onelineserver/master/apps/mysql.sh | bash