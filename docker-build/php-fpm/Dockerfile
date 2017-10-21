FROM php:7.1-fpm

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
    httping\
    npm \
    git \
    curl \
    xvfb \
    libfontconfig \
    wkhtmltopdf \
    xauth

RUN docker-php-ext-install \
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

RUN curl -fsS -o /tmp/icu.tgz -L http://download.icu-project.org/files/icu4c/59.1/icu4c-59_1-src.tgz \
  && tar -zxf /tmp/icu.tgz -C /tmp \
  && cd /tmp/icu/source \
  && ./configure --prefix=/usr/local \
  && make \
  && make install \
# just to be certain things are cleaned up
  && rm -rf /tmp/icu*

# PHP_CPPFLAGS are used by the docker-php-ext-* scripts
ENV PHP_CPPFLAGS="$PHP_CPPFLAGS -std=c++11"

RUN docker-php-ext-configure intl --with-icu-dir=/usr/local \
# run configure and install in the same RUN line, they extract and clean up the php source to save space
  && docker-php-ext-install intl

RUN rm -rf /var/lib/apt/lists/*

RUN ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g grunt-cli bower

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY php.ini                 /usr/local/etc/php/
COPY www.conf                /usr/local/etc/php-fpm.d/www.conf
COPY docker-entrypoint.sh    /usr/local/bin/
COPY docker-entrypoint-parts /usr/local/bin/

WORKDIR /var/www/site

ENTRYPOINT ["docker-entrypoint.sh"]
# CMD override important for current docker-entrypoint.sh content
# fix error:  $1: unbound variable
CMD ["php-fpm"]

# supervisord
#ADD docker-build/php-fpm/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
#CMD ["/usr/bin/supervisord"]
