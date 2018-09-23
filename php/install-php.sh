#!/usr/bin/env bash
clear

source ./_shared/util.sh
source ./_shared/repo.sh

main() {
    logo
    log info "This script is designed to serve as a version control system(VCS) for php."
    log info "type version (enter 'default' for standard repository package)"
    log info "eg: 5.6 | 7.1, | 7.3"

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
        log info "fetching PHP version: ${VERSION}"
        if [[ $(repo_check) != "1" ]]; then
            repo_install
        fi

        if [ "$VERSION_DIGITS" -gt "54" ] && [ "$VERSION_DIGITS" -lt "56" ]; then
            repo_install68
        fi

        if [[ $(repo_utils_check) != "1" ]]; then
            repo_utils
        fi

        if [[ $(repo_configured) != "1" ]]; then
            repo_enable "remi-php$VERSION_DIGITS"
        fi
    fi

    # install packages & base modules
    # include module lib
    modules=$(./php/modules-php.sh $VERSION_DIGITS)
    line="yum -y install php php$VERSION_DIGITS $modules"
    log cmd "installing packages:" "$line" & $($line > /dev/null 2>&1) || log error "failed to install php & co" & spinner
    #echo php -v

    log info "Goodbye!"
}

main
