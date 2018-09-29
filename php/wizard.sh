#!/usr/bin/env bash
source ./_shared/util.sh
source ./_shared/repo.sh
source ./_shared/UI.sh

# TODO:: add makefile
# TODO:: add config file

clearScreen
clearLogFile

main() {
    logo
    log info "This script is designed to serve as a version control system (VCS) for php."
    log note "..."
    log note "..."

    # check for older installs
    ./php/vcs/remove.sh

    # being interactive install
    ./php/vcs/install.sh
}

#main
echo $(get_configured_remi_repos)