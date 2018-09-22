#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh

get_installed_remi_repos() {
#    repolist="cat php/yum.repolist.mock"
    repolist="yum repolist"
    regex="^remi-[0-9a-z]\+"

    # return
    echo $($repolist | grep -o $regex)
}

main() {
    logo
    echo "\n"

    remi=$(get_installed_remi_repos)
    if [[ $remi!="" ]]; then
        line="yum-config-manager --disable $remi"
        log cmd "'$line'"
        echo $($line)
    fi

    v=$(only_digits $(get_php_version))
    if [ $v != "" ]; then
        # include module lib
        modules=$(./php/modules-php.sh $v)
        line="yum -y remove php php-* php$v $modules"
        log cmd "'$line'"
        echo $($line) || log error "could not remove packages" && exit 2
    else
        line="yum -y remove php php-*"
        log cmd "'$line'"
        echo $($line) || log error "could not remove packages" && exit 2
    fi
    
}

main
