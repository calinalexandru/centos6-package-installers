#!/usr/bin/env bash

os_is_supported() {
}

get_os_name() {
    if [ "$(cat /etc/os-release | grep Ubuntu | wc -l)" != "0" ]; then
        echo "ubuntu"
    elif [ "$(cat /etc/os-release | grep Centos | wc -l)" != "0" ]; then
        echo "centos"
    fi;
}

get_repo_cmd() {
    os="$(get_os_name)"

    if [ "$os" = "ubuntu" ] || [ "$os" = "debian" ]; then
        echo "apt"
    elif [ "$os" = "centos" ]; then
        echo "yum"
    fi
}

get_kernel_version() {
    echo "0"
}
