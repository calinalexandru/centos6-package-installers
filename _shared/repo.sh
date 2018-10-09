#!/usr/bin/env bash
logFilePath="./php.vcs.log"

source "./_shared/util.sh"

repo_install6(){
    line="yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm"
    instr "$line" "installing repo-release-6"


    # log cmd "installing repo-release-6" "$line" & $($line > $logFilePath 2>&1) || log error "failed" & spinner
}

repo_install_remi6_check() {
    # yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm
    line=$(yum list installed | grep remi-release | wc -l || echo 0)
    echo "$line"
}

repo_install_remi6() {
    line="yum -y install http://rpms.remirepo.net/enterprise/remi-release-6.rpm"
    instr "$line" "installing repo-remi-6"
#    log cmd "installing repo-remi-6" "$line" & $($line > $logFilePath 2>&1) || log error "failed" & spinner
}

repo_enable() {
    line="yum-config-manager --enable $1"
    instr "$line" "enabling repo"
    # log cmd "enabling repo" "$line" & $($line > $logFilePath 2>&1) || log error "failed to enable repo" & spinner
}

repo_utils() {
    line="yum -y install yum-utils"
    instr "$line" "install yum-utils"
}

repo_utils_check() {
    # ./_shared/repo.sh: line 42: yum list installed | grep 'yum-utils': command not found (!??!)
    line=$(yum list installed | grep -i "yum-utils" | wc -l || echo 0)
    echo "$line"
}

# TODO:: enabler/disabler probably not working correctly
repo_disable() {
    line="yum-config-manager --disable $1"
    instr "$line" "disabling repo"
    # log cmd "disabling repo" "$line" & $($line > $logFilePath 2>&1) || log error "failed to disable repo" & spinner
}


# for versions 5.3, 5.4, 5.5
repo_install68() {
    log info "downloading repo-release-68"
    line="wget http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    $($line > $logFilePath 2>&1)
    # log cmd ".." "$line" & $($line > $logFilePath 2>&1) || log error ".." & spinner

    log info "unpacking repo-release-68"
    line="rpm -Uvh epel-release-6-8.noarch.rpm"
    $($line > $logFilePath 2>&1)

    rm -f epel-release-6-8.noarch.rpm

    # log cmd ".." "$line" & $($line > $logFilePath 2>&1) || log error ".." & spinner
}

repo_configured() {
    # TODO:: add check to see if not repo is already configured
    # yum-config-manager --enable remi-php-xx

    # return false
    echo "0"
}

get_configured_remi_repos() {
    repolist="yum-config-manager"
#    repolist="cat ./yum-config-manager.mock"

    regex="remi-[0-9a-z]\+"

    # return
    line= unique "$($repolist | grep -o $regex)"

    echo "$line"
}

get_installed_remi_repos() {
    repolist="yum repolist"
    # repolist="cat ./php/yum.repolist.mock"

    regex="remi-[0-9a-z]\+"

    # return
    line=$($repolist | grep -o $regex)
    # log info "'$line'"
    # execAL "$line"
    # instr "$line" "yum repolist"

    echo "$line"
}
