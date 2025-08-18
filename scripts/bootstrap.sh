#! /usr/bin/env sh

# Colors make the progress a whole lot easier to read
source ~/scripts/colors.source
source ~/scripts/os.source

# Detect running as admin
info Administrative permissions required. Detecting permissions...
case $(os) in
    "linux" | "macos"*)
        info "Prompting for sudo password..."
        if sudo -v; then
            # Keep-alive: update existing `sudo` time stamp until `setup.sh` has finished
            while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
            success "Sudo credentials updated."
        else
            error "Failed to obtain sudo credentials."
        fi
        ;;
    "windows")
        # TODO: If running on Win 11, enable sudo in developer OS options and use sudo
        if ! net session 1>/dev/null 2>&1; then
            error Failure: Current permissions inadequate. Run as admin.
            exit 1
        else
            success Success: Administrative permissions confirmed.
        fi
        ;;
    *)
        error Unknown OS
        exit 1
        ;;
esac

DIR=$(dirname "$0")
cd "$DIR"

#TODO: Configure windows, get starting point from gist
# Run that as a powershell script
# Make sure to enable stuff for rancher

# Something for windows terminal?

# Run these in parallel
info "Running ./packages/install.sh"
./packages/install.sh

find * -name "setup.sh" | while read setup; do
    info "Running ./$setup"
    ./$setup
done