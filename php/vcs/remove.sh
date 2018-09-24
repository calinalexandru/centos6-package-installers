#!/usr/bin/env bash

# include util functs
source ./_shared/util.sh
source ./_shared/repo.sh

main() {
    log info "checking up previous PHP installations.."
    log info "(swoosh)"

    if [ php_installed = "1" ]; then

        log info "load repository list"
        remi=$(get_installed_remi_repos)
        if [[ $remi != "" ]]; then
            repo_disable "$remi"
        fi

        v=$(only_digits get_php_version)
        if [ $v != "" ]; then
            modules=$(./php/lib/modules.sh $v)
            line="yum -y remove php php-* php$v $modules"
            log cmd "removing packages" "$line" & $($line > /dev/null 2>&1) || log error "failed to remove php & co" & spinner
        else
            line="yum -y remove php php-*"
            log cmd "removing packages" "$line" & $($line > /dev/null 2>&1) || log error "failed to remove php & co" & spinner
        fi

        line="yum clean all"
        log cmd "attempting to clean repository" "$line" & $($line > /dev/null 2>&1) || log error "failed to clean repository" & spinner
    else
        log info "php not installed previously"
    fi
}

main
