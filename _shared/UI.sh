#!/usr/bin/env bash
source ./_shared/colours.sh

logFilePath="./php.vcs.log"

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

clearLogFile(){
    echo "" > "$logFilePath"
}

logToFile(){
    echo -e "$1" >> $logFilePath 2>&1
}

execAL() {
    echo -e "$1" >> $logFilePath 2>&1
    $1 >> $logFilePath 2>&1 &
}

line_delimiter() {
    spit "$(paint "--------------------------------------------------------------------------------------" "inverted")"
}

spit() {
    echo -e $1
    logToFile "$1"
}

paint() {
    echo "$($2)$1$(clear)"
}

log() {
    pre=""
    color=""
    d=":"

    if [ "$1" = "head" ]; then
        spit "\n"
        echo "$(line_delimiter)"
    fi

    # decorate log type
    if [[ "$1" = "error" ]]; then
        color="light_red"
        pre=$(paint "e" "$color")

        # pre="$(light_red)e$(clear)"

    elif [ "$1" = "cmd" ]; then
        color="green"
        pre=$(paint "c" "$color")
        #pre="$(green)c$(clear)"

    elif [ "$1" = "info" ]; then
        color="light_blue"
        pre=$(paint "i" "$color")
        # pre="$(light_blue)i$(clear)"

    elif [ "$1" = "warn" ]; then
        color="yellow"
        pre=$(paint "w" "$color")
        # pre="$(yellow)w$(clear)"

    elif [ "$1" = "head" ]; then
        pre=""

    elif [ "$1" = "emote" ]; then
        pre=""

    elif [ "$1" = "quote" ]; then
        color="dim"
        pre=$(paint "*" "$color")
        # pre="$(dim)*$(clear)"

    elif [ "$1" = "note" ]; then
        color="dark_gray"
        pre="$(paint ">" "$color")"
        # pre="$(dim)>$(clear)"
    fi

    # special head case
    if [ "$1" = "head" ]; then
        spit "$(inverted)php/vcs/$2.sh $(clear)"

    elif [ "$1" = "emote" ]; then
        spit "$(light_blue_bg)$2$(clear)\n"

    elif [ "$1" = "note" ]; then
        spit "$(paint "$d" "$color") $pre $(paint "$d" "dim")$(paint " $2" "$color")"

    elif [ "$1" = "quote" ]; then
        spit "$(paint "$d" "dim") $pre $(paint "$d" "dim")$(paint " \" $2 \" " "dim")"

    # normal case
    else

        spit "$(dim)$d$(clear) $pre $(dim)$d$(clear) $2"
    fi

    # 3rd argument case
    if [ "$3" != "" ]; then
        if [ "$1" = "head" ]; then
            spit "\n$(dim)'$3'$(clear)\n"
        else
            spit "$(dim)'$3'$(clear)\n"
        fi
    fi

    if [ "$1" = "head" ]; then
        echo "$(line_delimiter)"
    fi
}


logo() {
    echo -e $(light_blue) && cat ./php/ascii && echo -e $(clear)
}

clearScreen() {
    echo -e '\0033\0143'
}
