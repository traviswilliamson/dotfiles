#!/bin/bash

source $HOME/scripts/colors.source

#--- File Explorer Settings ---
# Show hidden files
powershell "Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name Hidden -Value 1" || logerror "Failed to show hidden files"
# Show protected OS files
powershell "Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name ShowSuperHidden -Value 1" || logerror "Failed to show OS files"
# Show file extensions
powershell "Set-ItemProperty HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name HideFileExt -Value 0" || logerror "Failed to show file extensions"

# will expand explorer to the actual folder you're in
powershell "Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1" || logerror "Failed to expand explorer path"
#adds things back in your left pane like recycle bin
powershell "Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1" || logerror "Failed to show all items in explorer lef tpane"
#opens PC to quick access, not This PC
powershell "Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Value 0" || logerror "Failed to set explorer open location"

#--- Enable developer mode on the system ---
powershell "reg add \"HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\AppModelUnlock\" /t REG_DWORD /f /v \"AllowDevelopmentWithoutDevLicense\" /d \"1\"" || logerror "Failed to set devloper mode"
