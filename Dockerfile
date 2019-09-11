FROM isaackuang/alpine-base:3.8.1

RUN curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories && \
    apk --no-cache --progress add --virtual .build-deps \
    git gcc re2c g++ make php7-dev && \
    apk --no-cache --progress add \
    file libstdc++ zlib zlib-dev postgresql-dev \
    php7-cli@php php7-openssl@php php7-sockets@php && \
    cd /tmp && \
    wget https://github.com/swoole/swoole-src/archive/v4.4.5.tar.gz && \
    tar zxvf v4.4.5.tar.gz && \
    cd swoole-src-4.4.5 && \
    phpize && \
    ./configure && \
    make && make install && \
    cd /tmp && \
    git clone https://github.com/swoole/ext-postgresql.git && \
    cd ext-postgresql && \
    git checkout 1ccd2ffbdc6e6d1f7b067509817f4bf93fe1982a && \
    phpize && \
    ./configure && \
    make && make install && \
    apk --no-cache --progress del postgresql-dev && \
    apk --no-cache --progress add openssl openssl-dev libpq && \
    cd /tmp/swoole-src-4.4.5 && \
    phpize && \
    ./configure --enable-sockets --enable-http2 --enable-openssl && \
    make clean && make && make install && \
    cd /tmp && rm -rf * && \
    apk --no-cache --progress del .build-deps && \
    rm -rf /etc/php7/conf.d/00_sockets.ini

WORKDIR /var/www/html

COPY config /
