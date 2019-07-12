FROM isaackuang/alpine-base:3.8.0

RUN curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.3" >> /etc/apk/repositories && \
    apk --no-cache --progress add \
    libstdc++ openssl \
    php7-cli@php php7-openssl@php php7-sockets@php && \
    apk --no-cache --progress add --virtual .build-deps \
    gcc g++ zlib make openssl-dev php7-dev && \
    cd /tmp && \
    wget https://github.com/swoole/swoole-src/archive/v4.4.0.tar.gz && \
    tar zxvf v4.4.0.tar.gz && \
    cd swoole-src-4.4.0 && \
    phpize && \
    ./configure --enable-sockets --enable-http2 --enable-openssl && \
    make && make install && \
    cd /tmp && rm -rf * && \
    apk --no-cache --progress del .build-deps && \
    rm -rf /etc/php7/conf.d/00_sockets.ini


WORKDIR /var/www/html

COPY config /
