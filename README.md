CentOS6 popular packages installer:
==========================

Run as root / use sudo

Install LAMP
-----
runs apache/mysql/php installers using default repo

    curl https://raw.githubusercontent.com/calinalexandru/centos6-package-installers/master/php/install-php.sh | sh

Install PHP 6.x, 7.x
-----
you can specify version, this will update/change your repos.

don't pipe the curl result into bash because that will break the user prompting!

    
    curl https://raw.githubusercontent.com/calinalexandru/centos6-package-installers/master/php/install-php.sh
    sh php/install-php.sh
    
    Installing php...
    Choose version (press enter for default repo)
    (eg: 5,6 | 7.1 | 7,2 | 73 | ... )
    version:
