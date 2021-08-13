#!/bin/bash

cp /etc/nginx/nginx.conf /tmp/nginx.conf
if [ ! "${ENTRYPOINT_URL}" == "" ] ; then
  curl -L -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   curl -L -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   curl -L -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ ! $? == 0 ] &&   curl -L -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"

  if [ $? == 0 ]  ; then
    echo "Download from url ${ENTRYPOINT_URL} file success." 
#   tail -n 10 /tmp/entrypoint1.sh
    mv /tmp/entrypoint1.sh /entrypoint0.sh
  else
    echo "Download from url ${ENTRYPOINT_URL} file failed." 
  fi
else
  echo "Use default entrypoint0.sh."
fi
chmod +x /entrypoint0.sh

if [ -s /tmp/nginx.conf ] ; then
  nginx -t -c /tmp/nginx.conf
  nginx -c /tmp/nginx.conf -g 'daemon off;'
else
  nginx -t
  nginx -g 'daemon off;'
fi
#echo "################最后一条监听命令不能放入子进程中。"

