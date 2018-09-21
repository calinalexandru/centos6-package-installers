#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh

main() {
    logo

    v=$(only_digits $(get_php_version))

    if [[ $v != "" ]; then
        # include module lib
        modules=$(./php/modules-php.sh $v)
        line="yum -y remove php php$v $modules"
        log cmd "'$line'"
        $(line) || log error "could not remove packages" && exit 2
    elif
        line="yum -y remove php"
        log cmd "'$line'"
        $(line) || log error "could not remove packages" && exit 2
    fi 
    
}

main

