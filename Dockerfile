FROM isaackuang/alpine-base:3.8.1

RUN curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories && \
    apk --no-cache --progress add --virtual .build-deps \
    git gcc re2c g++ zlib make php7-dev && \
    apk --no-cache --progress add \
    file postgresql-dev libressl-dev libstdc++ libressl \
    php7-cli@php php7-openssl@php php7-sockets@php && \
    cd /tmp && \
    wget https://github.com/swoole/swoole-src/archive/v4.4.2.tar.gz && \
    tar zxvf v4.4.2.tar.gz && \
    cd swoole-src-4.4.2 && \
    phpize && \
    ./configure --enable-sockets --enable-http2 --enable-openssl && \
    make && make install && \
    cd /tmp && \
    git clone https://github.com/swoole/ext-postgresql.git && \
    cd ext-postgresql && \
    phpize && \
    ./configure && \
    make && make install && \
    cd /tmp && rm -rf * && \
    apk --no-cache --progress del .build-deps && \
    rm -rf /etc/php7/conf.d/00_sockets.ini


WORKDIR /var/www/html

COPY config /
