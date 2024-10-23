#!/usr/bin/env bash
set -e

# PHP > Start services
service memcached start
service nginx restart
php-fpm -D

bash