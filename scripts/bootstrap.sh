#! /usr/bin/env sh

# Colors make the progress a whole lot easier to read
source ~/scripts/colors.source

# Detect running as admin
echo Administrative permissions required. Detecting permissions...
if ! net session 1>/dev/null 2>&1; then
    error Failure: Current permissions inadequate. Run as admin.
    exit 1
else
    success Success: Administrative permissions confirmed.
fi

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