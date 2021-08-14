#!/bin/bash
###  第一行的内容必不可少


#v2ray-plugin版本
if [[ -z "${VER}" ]]; then
  VER="latest"
fi


if [[ -z "${PASSWORD}" ]]; then
  PASSWORD="5c301bb8-6c77-41a0-a606-4ba11bbab084"
fi


if [[ -z "${ENCRYPT}" ]]; then
  ENCRYPT="rc4-md5"
fi

if [[ -z "${V2_Path}" ]]; then
  V2_Path="/s233"
fi

if [[ -z "${PLUGIN}" ]]; then
  PLUGIN="v2ray-plugin"
fi


if [[ -z "${PLUGIN_OPTS}" ]]; then
   PLUGIN_OPTS="server;path=/s233}"
  if [ "${PLUGIN}" == "obfs-server" ] ; then
    PLUGIN_OPTS="obfs=http;obfs-host=www.bing.com;path=/"    
  fi
fi


if [[ -z "${QR_Path}" ]]; then
  QR_Path="/qr_img"
fi

cd /wwwroot
tar xvf wwwroot.tar.gz >/dev/null 2>/dev/null
rm -rf wwwroot.tar.gz

if [ ! -d /etc/shadowsocks-libev ]; then  
  mkdir /etc/shadowsocks-libev
fi

# TODO: bug when PASSWORD contain '/'
sed -e "/^#/d"\
    -e "s/\${PASSWORD}/${PASSWORD}/g"\
    -e "s/\${ENCRYPT}/${ENCRYPT}/g"\
    -e "s/\${PLUGIN}/${PLUGIN}/g"\
    -e "s|\${PLUGIN_OPTS}|${PLUGIN_OPTS}|g"\
    -e "s|\${V2_Path}|${V2_Path}|g"\
    /conf/shadowsocks-libev_config.json >  /etc/shadowsocks-libev/config.json

if [[ -z "${ProxySite}" ]]; then
  s="s/proxy_pass/#proxy_pass/g"
#  echo "site:use local wwwroot html"
else
  s="s|\${ProxySite}|${ProxySite}|g"
#  echo "site: ${ProxySite}"
fi

##[ ! "${NGINX_SERVER_URL}" == "" ] && wget -q -O download.tmp "$NGINX_SERVER_URL"
wget -q -O download.tmp "$NGINX_SERVER_URL"
[ ! -s download.tmp ] && wget -q -O download.tmp "$NGINX_SERVER_URL"
if [ -s download.tmp ] && [ ! "`grep \"server {\" download.tmp`" == "" ] ; then
 echo "Download from url ${NGINX_SERVER_URL} file success." 
else
  cp /conf/nginx_ss.conf ownload.tmp
  echo "Use default ss.conf."
fi

sed -e "/^#/d"\
    -e "s/\${AppName}/${AppName}/g"\
    -e "s/\${PORT}/${PORT}/g"\
    -e "s|\${V2_Path}|${V2_Path}|g"\
    -e "s|\${QR_Path}|${QR_Path}|g"\
    -e "$s"\
    download.tmp > /etc/nginx/conf.d/ss.conf
    
    
if [ ! "${NGINX_CONF_URL}" == "" ] ; then
  wget -q -O download1.tmp "$NGINX_CONF_URL"
  [ ! -s download1.tmp ] && wget -q -O download1.tmp "$NGINX_CONF_URL"
  if [ -s download1.tmp ] && [ ! "`grep \"worker_processes\" download1.tmp`" == "" ] ; then
    cp download1.tmp /tmp/nginx.conf
    echo "Download from url ${NGINX_CONF_URL} file success." 
  else
    cp /etc/nginx/nginx.conf /tmp/nginx.conf
    echo "Download from url ${NGINX_CONF_URL} file failed." 
  fi
else
    cp /etc/nginx/nginx.conf /tmp/nginx.conf
    echo "Use default nginx.conf."
fi

#echo =====================================================================
#echo 下载地址：${NGINX_CONF_URL}
#echo 以下为nginx配置文件：/etc/nginx/nginx.conf
#cat /etc/nginx/nginx.conf
#echo =====================================================================
#echo 以下为ss配置文件：/etc/nginx/conf.d/ss.conf
#cat /etc/nginx/conf.d/ss.conf
#echo =====================================================================

if [ "$AppName" = "no" ]; then
  echo "不生成二维码"
else
  [ ! -d /wwwroot/${QR_Path} ] && mkdir /wwwroot/${QR_Path}
  plugin=$(echo -n "v2ray;path=${V2_Path};host=${AppName}.herokuapp.com;tls" | sed -e 's/\//%2F/g' -e 's/=/%3D/g' -e 's/;/%3B/g')
  ss="ss://$(echo -n ${ENCRYPT}:${PASSWORD} | base64 -w 0)@${AppName}.herokuapp.com:443?plugin=${plugin}" 
  echo "${ss}" | tr -d '\n' > /wwwroot/${QR_Path}/index.html
  echo -n "${ss}" | qrencode -s 6 -o /wwwroot/${QR_Path}/v2.png
fi
rm -rf /etc/nginx/sites-enabled/* >/dev/null 2>/dev/null
#gost -L=ss+wss://${ENCRYPT}:${PASSWORD}@:2334?host=${AppName}&path=${V2_Path}_gost &
#RUNRUN="gost -L=ss+wss://aes-256-cfb:yzqyzq1234@:2334?host=${AppName}.herokuapp.com&path=/gostgostgost"
#if [ "${SECOND_PROXY_COMMAND}" == "" ] ; then
#  echo ${SECOND_PROXY_COMMAND}
#  $SECOND_PROXY_COMMAND &
#fi

rm -rf /etc/nginx/sites-enabled
#echo "nginx -g 'daemon off;'"
#ss-server -c /etc/shadowsocks-libev/config.json --plugin ${PLUGIN} --plugin-opts ${PLUGIN_OPTS} &
echo "Use default entrypoint0.sh"
echo "Use default entrypoint0.sh"
echo "Use default entrypoint0.sh"
echo "Use default entrypoint0.sh"
echo "Use default entrypoint0.sh"
#cat /tmp/nginx.conf
exit 0
