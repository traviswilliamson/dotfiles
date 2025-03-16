#! /usr/bin/env sh

# Colors make the progress a whole lot easier to read
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
NC='\033[0m'

# Detect running as admin
echo Administrative permissions required. Detecting permissions...
if ! net session 1>/dev/null 2>&1; then
    echo -e "${RED}Failure: Current permissions inadequate. Run as admin.${NC}"
    exit 1
else
    echo -e "${GREEN}Success: Administrative permissions confirmed.${NC}"
fi

DIR=$(dirname "$0")
cd "$DIR"

#TODO: Configure windows, get starting point from gist
# Run that as a powershell script
# Make sure to enable stuff for rancher

# Something for windows terminal?

# Run these in parallel
echo "./packages/install.sh"
./packages/install.sh

find * -name "setup.sh" | while read setup; do
    echo -e "${CYAN}running ./$setup${NC}"
    ./$setup
done