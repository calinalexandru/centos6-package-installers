#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh

main() {
    v=$(only_digits $(get_php_version))

    if [[ $v != "" ]; then
        # include module lib
        modules=$(./php/modules-php.sh $v)
        yum -y remove php$v $modules || log error "could not remove packages" && exit 2
    elif
        yum -y remove php || log error "could not remove packages" && exit 2
    fi 
    
}

main

