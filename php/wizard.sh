#!/usr/bin/env bash
source ./_shared/util.sh
source ./_shared/repo.sh
source ./_shared/UI.sh

clear

main() {
    logo
    log info "This script is designed to serve as a version control system (VCS) for php."
    log note ".. here lies the notes .."
    log note ".. some more notes .."


    # check for older installs
    ./php/vcs/remove.sh

    # being interactive install
    ./php/vcs/install.sh
}

main
