CentOS 6 package installer:
==========================

Useful for projects that use modern web frameworks: Symfony3, Symfony4, Laravel, Lumen, etc.

First, you should clone the entire repo and from the present directory update the permissions, like this: 
    
    chmod -R +x .

Install LAMP (quick install)
-----
runs apache/mysql/php installers using default repo: 

    sudo ./install-lamp.sh

Install PHP 6.x, 7.x (interactive install)
-----
you can specify version, this will update/change your repos:

    sudo ./php/install-php.sh
    
