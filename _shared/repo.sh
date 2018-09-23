#!/usr/bin/env bash
source "./_shared/util.sh"

repo_install6(){
    line="yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm"
    instr "$line" "installing repo-release-6"

    # log cmd "installing repo-release-6" "$line" & $($line > /dev/null 2>&1) || log error "failed" & spinner
}

repo_install_remi6() {
    line="yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm"
    instr "$line" "installing repo-remi-6"
#    log cmd "installing repo-remi-6" "$line" & $($line > /dev/null 2>&1) || log error "failed" & spinner
}

repo_enable() {
    line="yum-config-manager --enable $1"
    instr "$line" "enabling repo"
    # log cmd "enabling repo" "$line" & $($line > /dev/null 2>&1) || log error "failed to enable repo" & spinner
}

repo_utils() {
    line="yum -y install yum-utils"
    instr "$line" "install yum-utils"
}

repo_utils_check() {
    line="yum list installed | grep -i yum-utils"
    instr "$line" "check for yum-utils"
}

repo_disable() {
    line="yum-config-manager --disable $1"
    instr "$line" "disabling repo"
    # log cmd "disabling repo" "$line" & $($line > /dev/null 2>&1) || log error "failed to disable repo" & spinner
}

repo_install_remi6_check() {
    # TODO:: add check for repos which are not already installed
    # yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm

    # return false
    echo "1"
}

# for versions 5.3, 5.4, 5.5
repo_install68() {
    log info "downloading repo-release-68"
    line="wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    $($line > /dev/null 2>&1)
    # log cmd ".." "$line" & $($line > /dev/null 2>&1) || log error ".." & spinner

    log info "unpacking repo-release-68"
    line="rpm -Uvh epel-release-6-8.noarch.rpm"
    $($line > /dev/null 2>&1)

    rm -fr epel-release-6-8.noarch.rpm

    # log cmd ".." "$line" & $($line > /dev/null 2>&1) || log error ".." & spinner
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
    line=$(echo $($repolist | grep -o $regex))
    log info "'$line'"

    echo "$line"
}