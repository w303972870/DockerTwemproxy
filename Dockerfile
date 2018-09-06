FROM alpine:latest
MAINTAINER Eric.wang wdc-zhy@163.com

RUN mkdir -p /data/twemproxy/ 

WORKDIR /data/twemproxy
ADD redis_master.conf /root/

RUN apk add --no-cache --virtual .build-deps git autoconf automake libtool gcc g++ make && \
    git clone https://github.com/twitter/twemproxy.git /data/twemproxy/ && autoreconf -fvi && \
    ./configure && make && make install &&  rm -rf /data/twemproxy/* &&  rm -rf /var/cache/apk/* && mkdir -p /data/twemproxy/logs && \ 
    apk del .build-deps gcc g++ openssl-dev zlib-dev perl-dev pcre-dev make git autoconf automake libtool

RUN mv /root/redis_master.conf /data/twemproxy/redis_master.conf

CMD ["nutcracker" , "-c" , "/data/twemproxy/redis_master.conf" , "-p" , "/data/twemproxy/redis_master.pid" , "-o" , "/data/twemproxy/logs/redis_master.log" ]

