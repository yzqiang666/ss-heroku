FROM debian:sid

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode shadowsocks-libev nginx autoremove\
    && apt install  -y build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake git

    

COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh
