#!/bin/bash

cp /etc/nginx/nginx.conf /tmp/nginx.conf
if [ ! "${ENTRYPOINT_URL}" == "" ] ; then
  curl -s  -kL  -m 3  --retry 2  --retry-delay  0 --retry-max-time 10 --connect-timeout 6 -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  [ $? -gt 0 ] && curl -s  -kL  -m 3  --retry 2  --retry-delay  0 --retry-max-time 10 --connect-timeout 6 -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
  if [ -s /tmp/entrypoint1.sh ]  ; then
     echo "Download from url ${ENTRYPOINT_URL} file success." 
#   tail -n 10 /tmp/entrypoint1.sh
   mv /tmp/entrypoint1.sh /entrypoint0.sh
 fi
fi
chmod +x /entrypoint0.sh


nginx -t -c /tmp/nginx.conf
echo "################最后一条监听命令不能放入子进程中。"
nginx -c /tmp/nginx.conf -g 'daemon off;' 
