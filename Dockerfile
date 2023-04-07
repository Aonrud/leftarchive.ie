FROM php:7.4-apache

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

RUN docker-php-ext-configure gd --with-freetype --with-jpeg

RUN docker-php-ext-install \
    mysqli \
    xsl \
    zip \
    gd

RUN a2enmod rewrite

COPY site /var/www/html

RUN groupadd www-pub
RUN groupmod -g 1002 www-pub
RUN usermod -a -G www-pub www-data

RUN chown -R www-data:www-data /var/www/html/manifest

COPY config.php /var/www/html/manifest/config.php
