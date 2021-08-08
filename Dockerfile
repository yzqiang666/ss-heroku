FROM debian:sid

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt autoremove -y\
    && apt install --no-install-recommends -y build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake git\
    && cd simple-obfs\
    && git submodule update --init --recursive\
    && ./autogen.sh\
    && ./configure && make\
    && make install
    

COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

CMD /entrypoint.sh
