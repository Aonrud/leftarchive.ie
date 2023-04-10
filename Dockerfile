FROM php:7.4-apache

ARG upload=128M

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

RUN echo "upload_max_filesize = $upload\npost_max_size = $upload" > /usr/local/etc/php/conf.d/uploads.ini
    
#Setup apache modules
RUN a2enmod rewrite headers remoteip
COPY remoteip.conf /etc/apache2/conf-available/remoteip.conf
RUN a2enconf remoteip

#Copy in the website and set permissions
COPY site /var/www/html
RUN chown -R www-data:www-data /var/www/html/manifest
COPY config.php /var/www/html/manifest/config.php

#Set up shared group with host
RUN groupadd www-pub
RUN groupmod -g 1002 www-pub
RUN usermod -a -G www-pub www-data
