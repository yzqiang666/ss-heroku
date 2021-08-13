#!/bin/bash


[ ! "${ENTRYPOINT_URL}" == "" ] && curl -sL -o  /tmp/entrypoint1.sh "$ENTRYPOINT_URL"
#if [ -s /tmp/entrypoint1.sh ] && [ ! "`grep \"#!/bin/bash\"`" == "" ]  ; then
if [ -s /tmp/entrypoint1.sh ]  ; then
   echo "Download from url ${ENTRYPOINT_URL} file success." 
#   tail -n 10 /tmp/entrypoint1.sh
   chmod +x /tmp/entrypoint1.sh
   /tmp/entrypoint1.sh
else
  chmod +x /entrypoint0.sh
  echo "Use default entrypoint0.sh"
  /entrypoint0.sh
fi


nginx -T -c /etc/nginx/nginx.conf
echo "################最后一条监听命令不能放入子进程中。"
nginx -g 'daemon off;' & 
echo "################结束初始化。"
