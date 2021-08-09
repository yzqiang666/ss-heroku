FROM debian:sid

RUN set -ex\
    && cp obfs-server /usr/local/bin\
    && cp wwwroot.tar.gz /wwwroot/wwwroot.tar.gz\
    && cp conf/ /conf\
    && cp entrypoint.sh /entrypoint.sh\    
    && apt update -y \
    && apt upgrade -y \
    && apt install -y curl wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt autoremove -y\
    && curl -L -o gost.gz https://github.com/ginuerzh/gost/releases/download/v2.11.1/gost-linux-amd64-2.11.1.gz\
    && gunzip gost.gz\
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
    && rm -rf /v2raybin
CMD /entrypoint.sh
