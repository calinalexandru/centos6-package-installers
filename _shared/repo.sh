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

repo_configured() {
    # TODO:: add check to see if not repo is already configured
    # yum-config-manager --enable remi-php-xx

    # return false
    echo "0"
}

get_installed_remi_repos() {
    repolist="yum repolist"
    regex="^remi-[0-9a-z]\+"

    # return
    echo $($repolist | grep -o $regex)
}