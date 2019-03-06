#!/bin/bash
 
DATADIR="/var/www/html/nextcloud/data/"
LOGFILE="/var/log/nextcloud-readonly.log"
 
exec &>> $LOGFILE
inotifywait -mrq -e create --format %w%f $DATADIR | while read FILE
do
    SEARCH=$(find $DATADIR -name files -type d -not -path "*appdata_*" -not -path "*files_trashbin*" -not -path "*ncadmin*")
    echo
    for i in $SEARCH; do
        if [ -w $i ]; then chmod u-w $i; fi
        echo $(date +"%T") "read-only:" $i
    done
done