#!/usr/bin/env bash
set -e

# PHP > Start services
service memcached start
php-fpm -D
nginx -g 'daemon off;'
