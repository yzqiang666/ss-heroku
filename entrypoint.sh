#!/bin/bash

cp /etc/nginx/nginx.conf /tmp/nginx.conf
if [ ! "${ENTRYPOINT_URL}" == "" ] ; then
  wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL" >/dev/null 2>/dev/null
  [ ! $? == 0 ] &&   wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL" >/dev/null 2>/dev/null
  [ ! $? == 0 ] &&   wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL" >/dev/null 2>/dev/null
  [ ! $? == 0 ] &&   wget -O  /tmp/entrypoint1.sh "$ENTRYPOINT_URL" >/dev/null 2>/dev/null
  if [ -s /tmp/entrypoint1.sh ]  ; then
    echo "Download from url ${ENTRYPOINT_URL} file success." 
    chmod +x /tmp/entrypoint1.sh
    /tmp/entrypoint1.sh
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
echo "=============  Finish entrypoint0.sh ====================="
if [ -s /tmp/nginx.conf ] ; then
  nginx -t -c /tmp/nginx.conf
  nginx -c /tmp/nginx.conf -g 'daemon off;'
else
  nginx -t
  nginx -g 'daemon off;'
fi
#echo "################最后一条监听命令不能放入子进程中。"

