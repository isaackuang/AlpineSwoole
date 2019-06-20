FROM isaackuang/alpine-base:3.8.0

RUN curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories && \
    apk --no-cache --progress add \
    libstdc++ openssl \
    php7-fpm@php php7-cli@php php7-openssl@php php7-dev php7-sockets && \
    apk --no-cache --progress add --virtual .build-deps \
    gcc g++ zlib make openssl-dev && \
    cd /tmp && \
    wget https://github.com/swoole/swoole-src/archive/v4.3.5.tar.gz && \
    tar zxvf v4.3.5.tar.gz && \
    cd swoole-src-4.3.5 && \
    phpize && \
    ./configure --enable-sockets --enable-http2 --enable-openssl && \
    make && make install && \
    cd /tmp && rm -rf * && \
    apk --no-cache --progress del .build-deps

COPY config /
