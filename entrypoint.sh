#!/bin/bash


[ ! "${ENTRYPOINT_URL}" == "" ] && wget --no-check-certificate  -O /entrypoint.tmp "$ENTRYPOINT_URL"
#sleep 3
#if [ -s /entrypoint.tmp ] && [ ! "`grep \"#!/bin/bash\" /entrypoint.tmp`" == "" ] ; then
#   echo "Download from url ${ENTRYPOINT_URL} file success." 
#   mv /entrypoint.tmp /entrypoint0.sh 
#   echo "################# USE NEW SHELL ##############" >>/entrypoint0.sh
#fi
chmod +x /entrypoint0.sh
/entrypoint0.sh

