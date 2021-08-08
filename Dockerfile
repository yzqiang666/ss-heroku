FROM debian:sid

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y wget curl unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt autoremove -y

COPY obfs-server /usr/local/bin
RUN chmod +x /usr/local/bin/obfs-server
COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh


    
#RUN apt install -y --no-install-recommends git build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake
#RUN git clone https://github.com/shadowsocks/simple-obfs.git\
#&& cd simple-obfs\
#&& git submodule update --init --recursive\
#&& ./autogen.sh\
#&& ./configure && make\
#&& make install

CMD /entrypoint.sh
