#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh
source ./_shared/repo.sh

main() {
    logo
    log info "This script will remove php & co"
    log info "(swoosh)"

    remi=$(get_installed_remi_repos)
    if [[ $remi != "" ]]; then
        repo_disable $remi
    fi

    v=$(only_digits $(get_php_version))
    if [ $v != "" ]; then
        modules=$(./php/modules-php.sh $v)
        line="yum -y remove php php-* php$v $modules"
        log cmd "removing packages via: '$line'" & $($line > /dev/null 2>&1) || log error "failed to remove php & co" & spinner
    else
        line="yum -y remove php php-*"
        log cmd "removing packages via: '$line'" & $($line > /dev/null 2>&1) || log error "failed to remove php & co" & spinner
    fi

    line="yum clean all"
    log cmd "'$line'" & $($line > /dev/null 2>&1) || log error "failed to clean repository" & spinner
}

main
