#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh

main() {
    logo

    v=$(only_digits $(get_php_version))

    if [ $v != "" ]; then
        # include module lib
        modules=$(./php/modules-php.sh $v)
        line="yum -y remove php php$v $modules"
        log cmd "'$line'"
        $(echo $line) || log error "could not remove packages" && exit 2
    else 
        line="yum -y remove php"
        log cmd "'$line'"
        $(echo $line) || log error "could not remove packages" && exit 2
    fi 
    
}

main

