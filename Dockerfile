FROM php:7-apache

RUN apt-get update \
    && apt-get install -y \
        git \
        libxslt1-dev \
        libzip-dev \
    && apt-get clean \
    && apt-get autoremove

RUN docker-php-ext-install \
    mysqli \
    xsl \
    zip

RUN a2enmod rewrite

COPY site /var/www/html
RUN chown -R www-data:www-data /var/www/html/workspace
RUN chown -R www-data:www-data /var/www/html/manifest

COPY config.php /var/www/html/manifest/config.php
