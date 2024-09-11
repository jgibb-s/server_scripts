#! /bin/bash

# Drive info--------------------------------------------------------------------------------
tdate="$(date +%Y.%m.%d-%H:%M)"
log="${HOME}/backup.log"
touch $log

STOR="${HOME}/storage"
BCKP="${HOME}/backup"

STOR_UUID="0f6be6fc-d1d0-4cf3-8c42-1e89b1e0e418"
BCKP_UUID="886b0197-e7b1-4a10-9f83-2c31d00c9cc3"
#-------------------------------------------------------------------------------------------


#disk test---------------------------------------------------------------------------------
# Check if the device is present
test -b "/dev/disk/by-uuid/${BCKP_UUID}" || ( echo "WARNING: $BCKP aint here boss" && exit 1 )
test $? == 0 || exit 1

# Check if the mountpoint is occupied
grep ${BCKP} /etc/mtab >& /dev/null
test $? == 0 || ( echo "WARNING: ${BCKP} aint mounted there champ"  && exit 1 )
test $? == 0 || exit 1
dname=$(grep ${BCKP} /etc/mtab | awk '{print $1}')

# Check if mountpoint corresponds to the device
test ${dname} -ef /dev/disk/by-uuid/${BCKP_UUID} || ( echo "WARNING: ${BCKP} mounted but not recognized yo" )
test $? == 0 || exit 1

cd $HOME

#/home and /media/storage
rsync -avz --delete ${STOR}/ ${BCKP}/ --exclude='downloads'

printf "$tdate - Full Backup\n$(cat $log)" > $log
