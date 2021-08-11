FROM debian:sid

COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY obfs-server /usr/local/bin
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh  
COPY entrypoint0.sh /entrypoint0.sh 

RUN set -ex\  
    && apt update -y \
    && apt upgrade -y \
    && apt install -y curl wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt install -y libnginx-mod-http-subs-filter\
    && apt install -y davfs2\
    && apt install -y cifs-utils\
    && apt autoremove -y\
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
    && wget --no-check-certificate "https://downloads.rclone.org/rclone-current-linux-amd64.zip"\
    && unzip rclone-current-linux-amd64.zip rclone-*/rclone\
    && mv rclone-*/rclone /usr/bin\
    && chmod +x /usr/bin/rclone\
    && rm -rf rclone*\
    && chmod 777 /entrypoint*.sh
    && chown root:root /entrypoint*.sh
    
CMD /entrypoint.sh


