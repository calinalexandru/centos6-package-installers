#!/usr/bin/env bash
echo 'Installing php...'

prompt_version_text() {
    echo 'Choose version (press enter for default repo)'
    echo '(eg: 5,6 | 7.1 | 7,2 | 73 | ... )'
}

prompt_version_input() {
    read -p 'version:' VERSION
    echo ${VERSION};
}

version_validate() {
    echo "${1}" | sed "s/[0-9]//g"
}

version_digits() {
    echo "${1}" | sed "s/[^0-9]//g"
}


while : ; do
    prompt_version_text

    VERSION=$(prompt_version_input)
    VERSION_DIGITS=$(version_digits ${VERSION})

    [[ "$VERSION" != "$VERSION_DIGITS" ]] || break

    if [[ "$VERSION_DIGITS" = "" ]]; then
        echo "Invalid version. Please use chars in this set [0-9\.\,]";
    else
        break
    fi
done

# prepare packages
if [ "${VERSION}" = '' ]; then
    echo 'Script will install default php'
else
    echo "Version is ${VERSION}"
    yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
    yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
    yum -y install yum-utils
    yum-config-manager --enable remi-php${VERSION_DIGITS}
fi

# install packages & base modules
yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
echo php -v
echo 'Goodbye!'
