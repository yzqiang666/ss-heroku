FROM debian:sid

RUN set -ex\
    && apt update -y \
    && apt upgrade -y \
    && apt install -y zlib-devel openssl-devel\
    && apt install -y wget unzip qrencode\
    && apt install -y shadowsocks-libev\
    && apt install -y nginx\
    && apt autoremove -y

COPY obfs-server /usr/local/bin
RUN chmod +x /usr/local/bin/obfs-server
COPY wwwroot.tar.gz /wwwroot/wwwroot.tar.gz
COPY conf/ /conf
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

RUN mkdir /v2raybin\
&& cd /v2raybin\
&& wget --no-check-certificate "https://github.com/shadowsocks/v2ray-plugin/releases/download/v1.3.1/v2ray-plugin-linux-amd64-v1.3.1.tar.gz"\
&& tar -zxvf v2ray-plugin-linux-amd64-v1.3.1.tar.gz\
&& rm -rf v2ray-plugin-linux-amd64-v1.3.1.tar.gz\
&& mv v2ray-plugin_linux_amd64 /usr/bin/v2ray-plugin\
&& cd /\
&& rm -rf /v2raybin
    
#RUN apt install -y --no-install-recommends git build-essential autoconf libtool libssl-dev libpcre3-dev libev-dev asciidoc xmlto automake
#RUN git clone https://github.com/shadowsocks/simple-obfs.git\
#&& cd simple-obfs\
#&& git submodule update --init --recursive\
#&& ./autogen.sh\
#&& ./configure && make\
#&& make install

CMD /entrypoint.sh
