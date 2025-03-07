#!/bin/bash

cp /etc/nginx/nginx.conf /tmp/nginx.conf
if [ ! "${ENTRYPOINT_URL}" == "" ] ; then
  wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  if [ -s /tmp/entrypoint1.sh ]  ; then
    echo "Download from url ${ENTRYPOINT_URL} file success." 
    chmod +x /tmp/entrypoint1.sh
    /tmp/entrypoint1.sh
  else
    echo "Download from url ${ENTRYPOINT_URL} file failed." 
    chmod +x /entrypoint0.sh
    /entrypoint0.sh
    RETCODE=$?
  fi
else
  echo "Use default entrypoint0.sh."
  chmod +x /entrypoint0.sh
  /entrypoint0.sh
  RETCODE=$?  
fi
if [ "$RETCODE" == "0" ] ; then
echo "=============  Finish entrypoint0.sh ====================="
if [ -s /tmp/nginx.conf ] ; then
  nginx -t -c /tmp/nginx.conf
  nginx -c /tmp/nginx.conf -g 'daemon off;'
else
  nginx -t
  nginx -g 'daemon off;'
fi
#echo "################最后一条监听命令不能放入子进程中。"
fi
