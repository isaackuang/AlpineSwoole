FROM isaackuang/alpine-base:3.8.0

RUN curl https://dl.bintray.com/php-alpine/key/php-alpine.rsa.pub -o /etc/apk/keys/php-alpine.rsa.pub && \
    echo "@php https://dl.bintray.com/php-alpine/v3.8/php-7.2" >> /etc/apk/repositories && \
    apk --no-cache --progress add \
    libstdc++ \
    php7-fpm@php php7-cli@php php7-openssl@php php7-sockets@php php7-swoole@php

COPY config /
