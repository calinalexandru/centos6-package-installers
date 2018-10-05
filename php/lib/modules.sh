#!/usr/bin/env bash

module_name() {
    # use normal naming for default vers (php-curl, php-xml)
    if [ "$1" = "0" ]; then
        echo "php-$2"

    # && version naming (php-curl php72-php-curl, php-xml php72-php-xml)
    else
        echo "php-$2 php$1-php-$2"
    fi
}

main() {
    modules=(pecl-mcrypt mbstring cli gd curl mysqlnd ldap zip fileinfo bz2 ctype calendar exif ftp gettext iconv json ldap mysqlnd pdo phar sockets sqlite3 tokenizer mysqli pdo_mysql pdo_sqlite xml pecl-memcache)
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
