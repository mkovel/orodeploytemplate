FROM php:7.1

RUN apt-get update && apt-get install -y --no-install-recommends \
    libicu-dev \
    libmcrypt-dev \
    libpng-dev \
    libxml2-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libtidy-dev \
    mc \
    netcat-openbsd \
    httping \
    npm \
    cron 

RUN docker-php-ext-install \
    intl \
    mbstring \
    mcrypt \
    opcache \
    pdo \
    pdo_mysql \
    soap \
    iconv \
    mysqli \
    zip \
    tidy \
    bcmath

RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd

# Xdebug for dev environment
ARG APP_ENV=dev
RUN printf "\033[0;36m===> \033[0;33m\$APP_ENV=$APP_ENV\033[0m\n"

RUN if [ "${APP_ENV}" = "dev" ];\
    then pecl install xdebug && docker-php-ext-enable xdebug;\
    else echo "";\
  fi

RUN pecl install \
  redis \
  apcu

RUN docker-php-ext-enable \
  redis \
  apcu

RUN apt-get install -y supervisor
# install last version
#RUN apt install python-pip -y
#RUN pip install --upgrade pip
#RUN pip install --upgrade supervisor
#CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]

RUN rm -rf /var/lib/apt/lists/*

COPY php.ini               /usr/local/etc/php/
COPY docker-entrypoint.sh  /usr/local/bin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

WORKDIR /var/www/site

ENTRYPOINT ["docker-entrypoint.sh"]
# CMD override important for current docker-entrypoint.sh content
# fix error:  $1: unbound variable
#CMD ["php-fpm"]

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf" ]