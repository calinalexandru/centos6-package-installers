#!/usr/bin/env bash

module_name(){
    echo "php$1-php-$2"
}

main() {
    modules=(mcrypt mbstring cli gd curl mysql ldap zip fileinfo bz2 ctype calendar exif ftp gettext iconv json ldap mysqlnd pdo phar sockets sqlite3 tokenizer mysqli pdo_mysql pdo_sqlite)
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
