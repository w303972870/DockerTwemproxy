FROM alpine:latest
MAINTAINER Eric.wang wdc-zhy@163.com

RUN apk add git autoconf automake libtool gcc g++ && mkdir -p /data/twemproxy/ && git clone https://github.com/twitter/twemproxy.git /data/twemproxy/
WORKDIR /data/twemproxy
RUN autoreconf -fvi && ./configure && make && make install && rm -rf ./* && rm -rf /var/cache/apk/* && mkdir -p /data/twemproxy/logs
ADD redis_master.conf .
RUN apk del gcc openssl-devel zlib-devel perl-devel pcre-devel make

CMD ["nutcracker" , "-c" , "/data/twemproxy/redis_master.conf" , "-p" , "/data/twemproxy/redis_master.pid" , "-o" , "/data/twemproxy/logs/redis_master.log" , "-d"]

