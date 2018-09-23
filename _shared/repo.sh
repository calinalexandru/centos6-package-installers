#!/usr/bin/env bash
source "./_shared/util.sh"
repo_install() {
    line="yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm"
    log cmd "registering repos" "$line" & $($line > /dev/null 2>&1) || log error "failed to register repo" & spinner
}

repo_enable() {
    line="yum-config-manager --enable $1"
    log cmd "enabling repo" "$line" & $($line > /dev/null 2>&1) || log error "failed to enable repo" & spinner
}

repo_utils() {
    line="yum -y install yum-utils"
    log cmd "installing yum-utils" "$line" & $($line > /dev/null 2>&1) || log error "yum-util fail" & spinner
}

repo_utils_check() {
    # TODO:: grep for installed utils

    #return false
    echo "0"
}

repo_disable() {
    line="yum-config-manager --disable $1"
    log cmd "disabling repo" "$line" & $($line > /dev/null 2>&1) || log error "failed to disable repo" & spinner
}

repo_check() {
    # TODO:: add check for repos which are not already installed
    # yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
    # yum -y install yum-utils

    # return false
    echo "0"
}

# for versions 5.3, 5.4, 5.5
repo_install68() {
    line="wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    log cmd ".." "$line" & $($line > /dev/null 2>&1) || log error ".." & spinner

    line="rpm -Uvh epel-release-6-8.noarch.rpm"
    log cmd ".." "$line" & $($line > /dev/null 2>&1) || log error ".." & spinner

    # rpm -Uvh "$(curl -s "http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm")"
}

repo_configured() {
    # TODO:: add check to see if not repo is already configured
    # yum-config-manager --enable remi-php-xx

    # return false
    echo "0"
}

get_installed_remi_repos() {
    repolist="yum repolist"
    # repolist="cat ./php/yum.repolist.mock"

    regex="remi-[0-9a-z]\+"


    rpm -Uvh epel-release-6-8.noarch.rpm

    # rpm -Uvh "$(curl -s "http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm")"
}

repo_configured() {
    # TODO:: add check to see if not repo is already configured
    # yum-config-manager --enable remi-php-xx

    # return false
    echo "0"
}

get_installed_remi_repos() {
    repolist="yum repolist"
    # repolist="cat ./php/yum.repolist.mock"

    regex="remi-[0-9a-z]\+"

    # return
    echo $($repolist | grep -o $regex)
}