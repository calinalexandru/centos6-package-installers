#!/usr/bin/env bash

get_php_version(){
    php -v | head -n 1 | grep -o 'PHP [0-9].[0-9]\+' | sed 's/PHP //g'
}

log() {
    pre=''

    if [[ "$1" = "error" ]]; then
        pre="; SCRIPT EXITED SUDDENLY!!! ;;\n"
    fi

    echo -e ";$pre; $2"
}

get_version_input() {
    read -r VERSION
#    read -p $(log prompt "php-v: ") VERSION
    echo $VERSION;
}

version_validate() {
    echo "${1}" | sed "s/[0-9]//g"
}

only_digits() {
    echo "${1}" | sed "s/[^0-9]//g"
}

logo() {
    cat ./php/ascii
    echo -e "\n"
}
