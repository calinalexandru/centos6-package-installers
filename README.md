
    ** dev release currently **

# CentOS 6 package installers:

>useful for projects that use modern web frameworks: Symfony3, Symfony4, Laravel, Lumen, etc.

First, you should clone the entire repo and from the present directory update the permissions, like this: 
    
    chmod -R +x .

### install php, apache, mysql - quick install
run each installers using RPM stable version: 

    sudo ./install-quick.sh

### install php 6.x, 7.x - interactive install
>appends [remirepo](https://rpms.remirepo.net/)_ to your RPM package list.

    sudo ./php/install-php.sh
## notes
> - PHP scripts will require (automatically): [remirepo](https://rpms.remirepo.net/)