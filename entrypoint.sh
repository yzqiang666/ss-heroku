#!/bin/bash


[ ! "${ENTRYPOINT_URL}" == "" ] && wget --no-check-certificate  -O /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
sleep 3
if [ -s /tmp/entrypoint1.sh ]  ; then
   echo "Download from url ${ENTRYPOINT_URL} file success." 
   tail -n 10 /tmp/entrypoint1.sh
   chmod +x /tmp/entrypoint1.sh
   /tmp/entrypoint1.sh
else
  chmod +x /entrypoint0.sh
  /entrypoint0.sh
fi

################最后一条监听命令不能放入子进程中。
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===========================================================
echo ===========================================================
cat /etc/nginx/nginx.conf
echo ===========================================================
cat /etc/nginx/conf.d/*
nginx -g 'daemon off;'
echo "Finsh ungix"
echo ===========================================================




