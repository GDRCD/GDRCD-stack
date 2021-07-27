FROM php:5.6-fpm-alpine

WORKDIR /var/www/service/

RUN set -ex; \
    \
    apk add --no-cache --virtual .build-deps \
    libjpeg-turbo-dev \
    libpng-dev \
    ; \
    \
    docker-php-ext-configure gd --with-png-dir=/usr --with-jpeg-dir=/usr; \
    docker-php-ext-install gd mysqli pdo_mysql opcache zip;

