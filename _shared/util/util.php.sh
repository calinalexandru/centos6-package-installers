#!/usr/bin/env bash

get_php_version() {
    echo $(php -v | head -n 1 | grep -o "PHP [0-9].[0-9]\+" | sed "s/PHP //g")
}

php_installed() {
    local check=$(php -v || echo 0)

    if [ "$check" = "0" ]; then
        echo "0"
    else
        echo "1"
    fi
}

get_version_input() {
    read -r VERSION
    echo $VERSION;
}

valid_version() {
    if (( "$1" >= "53" )) && (( "$1" <= "56" )) || (( "$1" >= "70" )) && (( "$1" <= "73" )); then
        echo "1"
    else
        echo "0"
    fi
}
