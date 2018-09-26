#!/usr/bin/env bash
source ./_shared/colours.sh
source ./_shared/UI.sh
source ./_shared/util/util.php.sh

# TODO :: write output to file
instr() {
    line="$1"
    logFile="./php.vcs.log"

    if [ "$2" = "" ]; then
        log cmd "" "$line" & $($line >> $logFile 2>&1) || log error "failed" & spinner
    else
        log cmd "$2" "$line" & $($line >> $logFile 2>&1) || log error "failed" & spinner
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

unique() {
    echo $1 | tr ' ' '\n' | sort -u | tr '\n' ' '
}

