#! /bin/bash

DATE=$(date +%Y%m%d)
BACKUP_DIR=/mnt/storage/backups


cd ~/
mv docker_bkp-*.tar.bz2 docker_bkp.temp
tar cjvf docker_bkp-$DATE.tar.bz2 --exclude='docker/photoprism/*' --exclude='docker/transmission/downloads/*' docker/
rm -rf docker_bkp.temp

if [[ $(ls -1 ${BACKUP_DIR}/docker_bkp*.tar.bz2 | wc | awk '{print $1}') -ge 3 ]]; then
    for i in $(ls ${BACKUP_DIR}/docker_bkp*.tar.bz2 | head -n 2); do
	rm $i
    done
fi

mv docker_bkp-$DATE.tar.bz2 ${BACKUP_DIR}/
