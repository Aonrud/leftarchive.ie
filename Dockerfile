FROM php:7.4-apache

ARG upload=256M

RUN apt-get update \
    && apt-get install -y \
        git \
        libxslt1-dev \
        libfreetype6-dev \
		libjpeg62-turbo-dev \
        libzip-dev \
        libpng-dev \
    && apt-get clean \
    && apt-get autoremove

RUN docker-php-ext-configure gd --with-freetype --with-jpeg && \
    docker-php-ext-install \
    opcache \
    pdo_mysql \
    mysqli \
    xsl \
    zip \
    gd

RUN { \
    echo "opcache.memory_consumption=128"; \
    echo "opcache.interned_strings_buffer=8"; \
    echo "opcache.max_accelerated_files=4000"; \
    echo "opcache.revalidate_freq=60"; \
    echo "opcache.enable_cli=1"; \
    echo "upload_max_filesize=${upload}"; \
    echo "post_max_size=${upload}"; \
    } > /usr/local/etc/php/conf.d/custom.ini && \
    a2enmod rewrite headers remoteip && \
    { \
    echo "RemoteIPHeader X-Forwarded-For"; \
    echo "RemoteIPTrustedProxy 192.168.0.0/24"; \
    } > /etc/apache2/conf-available/remoteip.conf && \
    a2enconf remoteip

#Copy in the website and set permissions
COPY site /var/www/html
RUN chown -R www-data:www-data /var/www/html/manifest
COPY config.php /var/www/html/manifest/config.php

#Set up shared group with host
RUN groupadd www-pub && groupmod -g 1002 www-pub && usermod -a -G www-pub www-data
