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
   ascii="ICAgICAgICAgICBfXyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIAogICAgX19fXyAgLyAvXyAgX19fXyAgICAgICBfICAgX19fX19fX19fX19fCiAgIC8gX18gXC8gX18gXC8gX18gXF9fX19ffCB8IC8gLyBfX18vIF9fXy8KICAvIC9fLyAvIC8gLyAvIC9fLyAvX19fX18vIHwvIC8gL19fKF9fICApIAogLyAuX19fL18vIC9fLyAuX19fLyAgICAgIHxfX18vXF9fXy9fX19fLyAgCi9fLyAgICAgICAgIC9fLyAgICAgICAgICAgICAgICAgICAgICAgICAgICA="
    base64 -D <<< $ascii || base64 -d <<< ascii
    echo -e "\n"
}
