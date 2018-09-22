#!/usr/bin/env bash
clear

source ./_shared/util.sh

main() {
    logo
    log info "This script is designed to serve as a version control system(VCS) for php."
    log info "type version (enter 'default' for standard repository package)"
    log info "eg: 4.2 | 7.1, | 7.3"

    # loop prompt version (for validation)
    while : ; do
        VERSION=$(get_version_input)
        VERSION_DIGITS=$(only_digits ${VERSION})

        [[ "$VERSION" != "default" ]] || break

        if [[ "$VERSION_DIGITS" = "" ]]; then
            log warn "invalid version; chars out of range [0-9\.\,]"
            log info "eg: 4.2 | 7.1, | 7.3"
        else
            break
        fi
    done

    # prepare packages
    if [ "${VERSION}" = "" ]; then
        log info "installing default repo version"
    else
        log info "installing version: ${VERSION}"
        yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
        yum -y install yum-utils
        yum-config-manager --enable remi-php${VERSION_DIGITS}
    fi

    # install packages & base modules
    # include module lib
    modules=$(./php/modules-php.sh $VERSION_DIGITS)

    line="yum -y install php php$VERSION_DIGITS $modules"
    log cmd "'$line'"
    $(echo $line) || log error "packages could not be installed" && exit 2

    #yum -y install php php-${VERSION_DIGITS}mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
    #echo php -v
    #echo "Goodbye!"
}

main
