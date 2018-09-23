#!/usr/bin/env bash
source "./_shared/colours.sh"

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

instr() {
    line="$1"

    if [ "$2" = "" ]; then
        log cmd "" "$line" & $($line > /dev/null 2>&1) || log error "failed" & spinner
    else
        log cmd "$2" "$line" & $($line > /dev/null 2>&1) || log error "failed" & spinner
    fi
}

spit() {
    echo -e $1
}

get_php_version(){
    echo $(php -v | head -n 1 | grep -o "PHP [0-9].[0-9]\+" | sed "s/PHP //g")
}

log() {
    pre=''
    if [[ "$1" = "error" ]]; then
        pre="$(light_red)e$(clear)"

    elif [[ $1 = "cmd" ]]; then
        pre="$(green)c$(clear)"

    elif [[ $1 = "info" ]]; then
        pre="$(light_blue)i$(clear)"

    elif [[ $1 = "warn" ]]; then
        pre="$(yellow)w$(clear)"
    fi

    d=":"

    spit "$(dim)$d$(clear)$pre$(dim)$d$(clear) ${yellow_bg}$2$c"

    if [[ $3 != "" ]]; then
        spit "$(dim)'$3'$(clear)"
    fi
}

get_version_input() {
    read -r VERSION
#    read -p $(log prompt "php-v: ") VERSION
    echo $VERSION;
}

valid_version() {
    if (( "$1" >= "53" )) && (( "$1" <= "56" )) || (( "$1" >= "70" )) && (( "$1" <= "73" )); then
        echo "1"
    else
        echo "0"
    fi
}

only_digits() {
    clean=$(echo "$1" | sed "s/[^0-9]//g")

    if [ "$clean" = "" ]; then
        echo "0"
    else
        echo "$clean"
    fi
}

logo() {
    clear
    echo -e $(light_blue) && cat ./php/ascii && echo -e $(clear)
}

