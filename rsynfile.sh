#!/bin/bash

set -e
REMOTE_IP="35.186.148.224"
REMOTE_PORT="10004"
REMOTE_DIR="/root/data/save_dir"
LOCAL_DIR="/home/tanlm/Downloads/lgg-mri-segmentation/remote_save_dir"
TIME_SLEEP=10

while [ true ]
do
  echo "Rsyn from remote server"
  echo "rsync -avzhe ssh -p ${REMOTE_PORT} root@${REMOTE_IP}:${REMOTE_DIR} ${LOCAL_DIR}"
  sh -c "rsync -avzhe \"ssh -p ${REMOTE_PORT}\" root@${REMOTE_IP}:${REMOTE_DIR} ${LOCAL_DIR}"
  echo "Sleeping"
  sleep $TIME_SLEEP
done