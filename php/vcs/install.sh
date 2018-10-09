#!/usr/bin/env bash
source ./_shared/colours.sh
source ./_shared/util.sh
source ./_shared/repo.sh
source ./_shared/UI.sh

main() {
    log head "install" "preparing packages.."

    log info "type version (enter 'default' for standard repository package)"
    log info "[ supported ]: 5.3 > 5.6, 7.0 > 7.3"

    # loop prompt version (for validation)
    while : ; do
        v="$(get_version_input)"
        vd="$(only_digits "$v")"

        if [ $(valid_version "$vd") = "0" ] && [ "$v" != "default" ]; then
            log warn "invalid version specified!"
            log warn "[ allowed ]: 5.3 > 5.6, 7.0 > 7.3"
        else
            break
        fi
    done

    # prepare packages
    if [ "$v" = "default" ]; then
        log info "configuring for default PHP version"
    else
        log info "configuring for PHP version: $v"

        if (( "$vd" >= "53" )) && (( "$vd" <= "56" )); then
            repo_install68
        elif (( "$vd" >= "70" )) && (( "$vd" <= "73" )); then

            log info "checking for remi-release"
            if [ "$(repo_install_remi6_check)" == "0" ]; then
                repo_install_remi6
            fi
        fi

        log info "checking for “yum-utils”"
        if [ "$(repo_utils_check)" == "0" ]; then
            repo_utils
        fi

        if [ "$(repo_configured)" != "1" ]; then
            repo_enable "remi-php$vd"
        fi
    fi

    log info "fetching PHP version: $v"

    modules="$(./php/lib/modules.sh $vd)"
    line="yum -y install php php$vd$modules"

    instr "$line" "installing php & co"

    instr "php -v" "displaying php version.."
    echo $(green)
    echo $(php -v || echo "we failed!")
    echo $(clear)

    log emote "Goodbye!"
}

main
