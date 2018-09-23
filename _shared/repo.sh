#!/usr/bin/env bash
source "./_shared/util.sh"
repo_install() {
    line="yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm"
    log info "registering repos via: '$line'" & $($line > /dev/null 2>&1) || log error "failed to register repo" & spinner
}

repo_enable() {
    line="yum-config-manager --enable $1"
    log info "enable repo" & $($line > /dev/null 2>&1) || log error "failed to enable repo" & spinner
}

repo_disable() {
    line="yum-config-manager --disable $1"
    log info "attempting to disable repo: '$line' " & $($line > /dev/null 2>&1) || log error "failed to disable repo" & spinner
}

repo_missing() {
    # TODO:: add check for repos which are not already installed
    # yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
    # yum -y install yum-utils

    # return true
    echo "1"
}

repo_not_configured() {
    # TODO:: add check to see if not repo is already configured
    # yum-config-manager --enable remi-php-xx

    # return true
    echo "1"
}

get_installed_remi_repos() {
    repolist="yum repolist"
    # mocked
    repolist="cat php/yum.repolist.mock"
    regex="^remi-[0-9a-z]\+"

    # return
    echo $($repolist | grep -o $regex)
}