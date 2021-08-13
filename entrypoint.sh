#!/bin/bash

cp /etc/nginx/nginx.conf /tmp/nginx.conf
if [ ! "${ENTRYPOINT_URL}" == "" ] ; then
  wget -O  entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   wget -O  entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   wget -O  entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   wget -O  entrypoint1.sh "$ENTRYPOINT_URL"

  if [ $? == 0 ]  ; then
    echo "Download from url ${ENTRYPOINT_URL} file success." 
    chmod +x entrypoint1.sh
    ./entrypoint1.sh
  else
    echo "Download from url ${ENTRYPOINT_URL} file failed." 
    chmod +x /entrypoint0.sh
    /entrypoint0.sh
  fi
else
  echo "Use default entrypoint0.sh."
  chmod +x /entrypoint0.sh
  /entrypoint0.sh
fi

if [ -s /tmp/nginx.conf ] ; then
  nginx -t -c /tmp/nginx.conf
  nginx -c /tmp/nginx.conf -g 'daemon off;'
else
  nginx -t
  nginx -g 'daemon off;'
fi
#echo "################最后一条监听命令不能放入子进程中。"

