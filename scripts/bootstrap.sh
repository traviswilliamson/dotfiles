#! /bin/bash

# Colors make the progress a whole lot easier to read
source $HOME/scripts/colors.source
source $HOME/scripts/os.source

# Detect running as admin
info "Administrative permissions required. Detecting permissions..."
case $(os) in
    "linux" | "macos")
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
            error "Failure: Current permissions inadequate. Run as admin."
            exit 1
        else
            success "Success: Administrative permissions confirmed."
        fi
        ;;
    *)
        error "Unknown OS"
        exit 1
        ;;
esac

initErrorLogs

DIR=$(dirname "$0")
pushd "$DIR" > /dev/null

#TODO: Configure windows, get starting point from gist
# Run that as a powershell script
# Make sure to enable stuff for rancher
# reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock" /t REG_DWORD /f /v "AllowDevelopmentWithoutDevLicense" /d "1"

# Something for windows terminal?

question "What kind of use is this machine for?"
select _env in "Work" "Personal"; do
    _env=${_env:-$REPLY}
    case $_env in
    [Ww]* )
        _env=work
        break
        ;;
    [Pp]* )
        _env=personal
        break
        ;;
    esac
done

find * -name "*.sh" | while read script; do
    if [[ ! -x "$script" ]] && [[ "$script" != "$(basename $0)" ]] then
        info "Making ./$script executable"
        chmod +x "$script" || error "Failed to make $script executable"
    fi
done

info "Running ./packages/install.sh\n"
./packages/install.sh $_env

find * -name "setup.sh" | while read setup; do
    info "Running ./$setup"
    ./$setup $_env
done

printErrorLogs
clearErrorLogs

popd > /dev/null
