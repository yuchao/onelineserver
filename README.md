#One Line Server

Run this on a fresh install. Tested on Ubuntu server 10.04, 10.10, 11.10, 12.04.

This script needs to be run under an account with `sudo` privileges.

`curl` needs to be installed first. - `sudo apt-get install curl`

This script was originally by [joshfng](https://github.com/joshfng/railsready), modified by [danharper](https://github.com/danharper/onelineserver) and modified (complete rewrite) by me! :)

## Ruby 1.9.3

### Ruby 1.9.3-p194 & Rubygems 1.8.24

	sudo curl -L http://qyk.in/0mc | bash
	


## Ruby on Rails setup

Installs Ruby 1.9.3, Rubygems, nginx, OpenSSL, ImageMagick, Git & nodejs

### With MySQL
	curl -L http://qyk.in/cqd | bash

### Without MySQL
	curl -L http://qyk.in/703 | bash




### Ruby 1.9.3 apt-get
Need a quicker installer for Ruby 1.9.3? Use the Brightbox apt-get repos by running this:

	curl -L http://qyk.in/h9w | bash

---

### Ruby 1.9.2

I'm not really updating the 1.9.2 install files. If you have problems with them, please fork, fix and create a pull request :)

#### Ruby 1.9.2-p318 & Rubygems 1.8.21
    sudo apt-get -y install curl && curl http://qyk.in/sfq >> 192.sh && chmod a+x 192.sh && sudo ./192.sh

#### Ruby 1.9.2 - Apache
    sudo apt-get -y install curl && curl http://qyk.in/7mi >> ruby192.sh && chmod a+x ruby192.sh && sudo ./ruby192.sh
	
	
---

