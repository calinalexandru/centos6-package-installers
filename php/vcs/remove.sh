#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh
source ./_shared/repo.sh
source ./_shared/UI.sh

main() {
    log head "remove" "looking for previous installations & configs"

    if [ "$(php_installed)" = "1" ]; then

        log info "load repository list"
        remi=$(get_installed_remi_repos)
        if [[ $remi != "" ]]; then
            repo_disable "$remi"
        fi

        v=$(only_digits "$(get_php_version)")

        if [ "$v" != "" ]; then
            modules=$(./php/lib/modules.sh $v)
            line="yum -y remove php php-* php$v $modules"
            instr "$line" "deleting php & co.."
        else
            line="yum -y remove php php-*"
            instr "$line" "deleting php & co.."
        fi

        line="yum clean all"
        instr "$line" "clearing repository cache"
        log emote " swoosh "
    fi

    log info "machine is PHP-sanitized"
}

main
