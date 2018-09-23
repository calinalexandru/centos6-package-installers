#!/usr/bin/env bash

source "./_shared/colours.sh"

spit() {
    echo -e $1
}

get_php_version(){
    php -v | head -n 1 | grep -o 'PHP [0-9].[0-9]\+' | sed 's/PHP //g'
}

log() {
    pre=''


    if [[ "$1" = "error" ]]; then
        pre="$(light_red)E$(clear)"

    elif [[ $1 = "cmd" ]]; then
        pre="$(green)C$(clear)"

    elif [[ $1 = "info" ]]; then
        pre="$(light_blue)i$(clear)"

    elif [[ $1 = "warn" ]]; then
        pre="$(yellow)W$(clear)"
    fi

    spit "$(dim);$(clear)$pre$(dim);$(clear) ${yellow_bg}$2$c"
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
    echo -e $(light_blue) && cat ./php/ascii && echo -e $(clear)
}

spinner()
{
    local pid=$!
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}
