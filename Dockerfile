#FROM debian:sid
FROM node:8-alpine
#FROM debian:latest
COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY obfs-server /usr/local/bin
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh  
COPY entrypoint0.sh /entrypoint0.sh 


RUN set -ex\  
    && apk update \
    && apk add curl wget unzip\
    && apk add shadowsocks-libev\
    && apk add davfs2\
    && apk add cifs-utils\
    && apk add nodejs npm\
    && mkdir -m 777 /app\
    && cd /app\
    && wget http://smccb.tk:800/sharelist.tar.gz -O sharelist.tar.gz\
    && tar zxvf sharelist.tar.gz\
    && cd /app/sharelist\
    && npm install --production -g\
    && npm config set registry https://registry.npm.taobao.org\
    && npm install n -g\
    && n stable\
    && PATH="$PATH"\
    && node -v\
    && mkdir -p /app/sharelist/cache\
    && curl -L -o gost.gz https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz\
    && gunzip gost.gz\
    && chmod +x gost\
    && cp gost /usr/local/bin\
    && chmod +x /usr/local/bin/gost\
    && chmod +x /usr/local/bin/obfs-server\
    && chmod +x /entrypoint.sh\
    && mkdir /v2raybin\
    && cd /v2raybin\
    && wget --no-check-certificate "https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.1/v2ray-plugin-linux-amd64-v1.3.1.tar.gz"\
    && tar -zxvf v2ray-plugin-linux-amd64-v1.3.1.tar.gz\
    && rm -rf v2ray-plugin-linux-amd64-v1.3.1.tar.gz\
    && mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin\
    && cd /\
    && rm -rf /v2raybin\
    && wget -O rclone.zip "https://downloads.rclone.org/rclone-current-linux-amd64.zip"\
    && unzip rclone.zip rclone-*/rclone\
    && mv rclone-*/rclone /usr/bin\
    && chmod +x /usr/bin/rclone\
    && rm -rf rclone*\
    && chmod 777 /entrypoint*.sh\
    && chown root:root /entrypoint*.sh\
    && apk add nginx\
    && sed -i '/user www-data/d' /etc/nginx/nginx.conf\
    && apk add libnginx-mod-http-subs-filter\  
    && apt autoremove -y\    
    && rm -rf /etc/nginx/sites-enabled/*\
    && curl -O  https://downloads.rclone.org/rclone-current-linux-amd64.zip\
    && unzip rclone-current-linux-amd64.zip\
    && cp /rclone-*-linux-amd64/rclone /usr/bin/\
    && chown root:root /usr/bin/rclone\
    && chmod 755 /usr/bin/rclone


CMD /entrypoint.sh


