#!/usr/bin/env bash

# prompt user for input
clear
echo 'Installing php...'
echo 'Choose version(press enter for OS default)'
echo 'Suggested: 7.0, 7.1, 7.2'
read -p ':' PHP_VERSION


# prepare packages
if [ "$PHP_VERSION" != '' ]; then
    echo 'Script will install default php'
else
    PHP_VERSION_CLEAN= echo ${PHP_VERSION} | sed "s/[^0-9]//g"
    echo "Version is ${PHP_VERSION_CLEAN}"
    yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
    yum install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
    yum install yum-utils
    yum-config-manager --enable remi-php${PHP_VERSION_CLEAN}
fi

# install packages
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
echo 'Done. Goodbye'
