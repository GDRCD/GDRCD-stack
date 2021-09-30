# Create image based on the official PHP-FMP image
FROM php:5.6-fpm

ENV DEBIAN_FRONTEND noninteractive

# Arguments defined in docker-compose.yml
ARG uid

# Update the base libraries
RUN apt-get -y update --fix-missing && apt-get upgrade -y

# Install useful tools and install important libaries
RUN apt-get -y --no-install-recommends install --fix-missing \
    git nano wget dialog \
    apt-utils build-essential \
    zip openssl curl \
    libsqlite3-dev \
    libsqlite3-0 \
    default-mysql-client \
    zlib1g-dev \
    libzip-dev \
    libicu-dev \
    libonig-dev \
    libcurl3-dev \
    libcurl3-openssl-dev \
    libmemcached-dev \
    zlib1g-dev

# Other PHP5.6 Extensions
RUN echo "Installing PHP extensions" && \
    docker-php-ext-install pdo_mysql && \
    docker-php-ext-install pdo_sqlite && \
    docker-php-ext-install mysqli && \
    docker-php-ext-install curl && \
    docker-php-ext-install tokenizer && \
    docker-php-ext-install json && \
    docker-php-ext-install zip && \
    docker-php-ext-install mbstring && \
    docker-php-ext-install gettext

# Other PHP5.6 Extensions
RUN echo "Enabling PHP extensions" && \
    docker-php-ext-enable pdo_mysql && \
    docker-php-ext-enable pdo_sqlite && \
    docker-php-ext-enable mysqli && \
    docker-php-ext-enable zip

# Install intl extension
RUN echo "Install PHP Intl" \
    && docker-php-ext-configure intl \
    && docker-php-ext-install -j$(nproc) intl \
    && docker-php-ext-enable intl \
    && rm -rf /tmp/*

# Install xdebug
RUN echo "Install xDebug" \
    && pecl install xdebug-2.5.5 \
    && docker-php-ext-enable xdebug

# Install redis
RUN echo "Install Redis" \
    && pecl install redis-2.2.8 \
    && docker-php-ext-enable redis

# Clean up, try to reduce image size (much as you can on Debian..)
RUN apt-get autoremove -y \
  && apt-get clean all \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /usr/share/doc /usr/share/man /usr/share/locale \
  && rm -f /usr/local/etc/php-fpm.d/*.conf \
  && rm -rf /usr/src/php

# Add user for web application
RUN groupadd -g $uid www
RUN useradd -u $uid -ms /bin/bash -g www www

# Copy existing application directory contents
COPY . /var/www/html

# Copy existing application directory permissions
COPY --chown=www:www . /var/www/html

# Change current user to www
USER www

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]