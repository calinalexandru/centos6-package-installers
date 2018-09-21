#!/usr/bin/env bash

module_name(){
    echo "php$1-php-$2"
}

main() {
    modules=(mcrypt cli gp curl mysql ldap zip fileinfo)
    c=""
    i=0
    while [ "x${modules[i]}" != "x" ]
    do
        name=$(module_name $1 ${modules[i]})
        c="$c $name"

    #    c="$c php$VERSION_DIGITS-${modules[i]} "
        i=$(( $i+ 1 ))
    done

    echo "$c"
}

main $1
