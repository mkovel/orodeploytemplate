FROM php:7.1.2-fpm

RUN apt-get update && apt-get install -y --no-install-recommends \
    git \
    libicu-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    npm \
    cron \
    supervisor \
    curl

RUN docker-php-ext-install \
    intl \
    mbstring \
    mcrypt \
    opcache \
    pdo \
    pdo_mysql \
    soap \
    zip

#gdw
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

COPY config/php/php.ini /usr/local/etc/php/
COPY config/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Install front
RUN ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g grunt-cli bower

# install xdebug
#RUN pecl install xdebug
#RUN docker-php-ext-enable xdebug
#RUN echo "error_reporting = E_ALL" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_startup_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "display_errors = On" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_connect_back=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.idekey=\"PHPSTORM\"" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
#RUN echo "xdebug.remote_port=9001" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

RUN rm -rf /var/lib/apt/lists/*

WORKDIR /var/www

CMD ["/usr/bin/supervisord"]