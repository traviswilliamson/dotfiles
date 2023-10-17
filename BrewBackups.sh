BREWFILE_BACKUP_LOCATION=~/Documents/Brewfiles
DATE=`date +%d-%m-%Y`

cd /tmp
brew bundle dump
mv Brewfile "$BREWFILE_BACKUP_LOCATION/Brewfile-$DATE"