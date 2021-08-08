FROM debian:sid

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt autoremove -y

RUN apt install -y build-essential\
    && apt install -y autoconf\
    && apt install -y wlibtool libssl-dev libpcre3-dev libev-dev\
    && apt install -y asciidoc xmlto automake\
    && apt install -y git
    
###RUN apt install  -y build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake git

    

COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh
