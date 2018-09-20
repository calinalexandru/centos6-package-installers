#!/usr/bin/env bash

# prompt user
clear
echo 'Installing php...'
echo 'Choose version(press enter for OS default)'
echo 'Suggested: 7.0, 7.1, 7.2'
read -p ':' VERSION

# prepare packages
if [ "$VERSION" != '' ]; then
    echo 'Script will install default php'
else
    VERSION_CLEAN= echo ${VERSION} | sed "s/[^0-9]//g"
    echo "Version is ${VERSION_CLEAN}"
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
    yum -y install yum-utils
    yum-config-manager --enable remi-php${VERSION_CLEAN}
fi

# install packages & base modules
yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
echo php -v
echo 'Goodbye! '