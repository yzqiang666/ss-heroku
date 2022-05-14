#FROM debian:sid
FROM debian:latest
COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY obfs-server /usr/local/bin
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh  
COPY entrypoint0.sh /entrypoint0.sh 

RUN set -ex\  
    && apt update -y \
    && apt install -y curl wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && mkdir /v2raybin\
    && cd /v2raybin\
    && wget --no-check-certificate "https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.1/v2ray-plugin-linux-amd64-v1.3.1.tar.gz"\
    && tar -zxvf v2ray-plugin-linux-amd64-v1.3.1.tar.gz\
    && rm -rf v2ray-plugin-linux-amd64-v1.3.1.tar.gz\
    && mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin\
    && cd /\
    && rm -rf /v2raybin\
    && chmod 777 /entrypoint*.sh\
    && chown root:root /entrypoint*.sh\
    && apt install -y nginx\
    && sed -i '/user www-data/d' /etc/nginx/nginx.conf\
    && apt install -y libnginx-mod-http-subs-filter\  
    && apt autoremove -y\    
    && rm -rf /etc/nginx/sites-enabled/*\
    && cd /wwwroot\
    && tar zxvf wwwroot.tar.gz\
    && rm *.tar.gz
      
CMD /entrypoint.sh

