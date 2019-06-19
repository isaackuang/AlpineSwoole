FROM isaackuang/alpine-base:3.8.0

RUN curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories && \
    apk --no-cache --progress add \
    libstdc++ \
    php7-fpm@php php7-cli@php php7-openssl@php php7-dev php7-sockets && \
    apk --no-cache --progress add --virtual .build-deps \
    gcc g++ zlib make && \
    cd /tmp && \
    wget https://github.com/swoole/swoole-src/archive/v4.2.10.tar.gz && \
    tar zxvf v4.2.10.tar.gz && \
    cd swoole-src-4.2.10 && \
    phpize && \
    ./configure --enable-sockets && \
    make && make install && \
    apk --no-cache --progress del .build-deps

COPY config /
