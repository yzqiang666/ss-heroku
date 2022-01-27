#FROM debian:sid
FROM debian:latest
COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY emby.tar.gz /wwwroot/emby.tar.gz
COPY obfs-server /usr/local/bin
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh  
COPY entrypoint0.sh /entrypoint0.sh 

RUN set -ex\  
    && apt update -y \
    && apt install -y curl wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y davfs2\
    && apt install -y cifs-utils\
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
    && apt install -y nginx\
    && sed -i '/user www-data/d' /etc/nginx/nginx.conf\
    && apt install -y libnginx-mod-http-subs-filter\  
    && apt install -y nodejs npm\
    && apt autoremove -y\    
    && rm -rf /etc/nginx/sites-enabled/*\
    && curl -O  https://downloads.rclone.org/rclone-current-linux-amd64.zip\
    && unzip rclone-current-linux-amd64.zip\
    && cp /rclone-*-linux-amd64/rclone /usr/bin/\
    && chown root:root /usr/bin/rclone\
    && chmod 755 /usr/bin/rclone\
    && mkdir -m 777 /app\
    && cd /app\
    && wget https://raw.githubusercontent.com/yzqiang666/mydoc/main/sharelist.tar.gz -O sharelist.tar.gz\
    && tar zxvf sharelist.tar.gz >/dev/null 2>/dev/null\
    && cd /app/sharelist\
    && mkdir -p /app/sharelist/cache\
    && npm install --production -g\   
    && npm install n -g\   
    && n stable\  
    && /usr/local/bin/node -v\ 
    && /usr/local/bin/npm install -g npm@8.3.2\
    && /usr/local/bin/npm install || echo npm install error!!!\
    && npm install || echo npm install error!!!\
    && cd /wwwroot\
    && tar zxvf wwwroot.tar.gz\
    && tar zxvf emby.tar.gz\
    && rm *.tar.gz
      
CMD /entrypoint.sh

