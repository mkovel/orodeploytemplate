FROM debian:jessie

RUN apt-get update && apt-get install -y \
    nginx

ADD nginx.conf /etc/nginx/
ADD sites-available/* /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/*.conf /etc/nginx/sites-enabled/
RUN rm /etc/nginx/sites-enabled/default

RUN echo "upstream php-upstream { server php:9000; }" > /etc/nginx/conf.d/upstream.conf

RUN usermod -u 1000 www-data

#clear apt-get list
RUN rm -rf /var/lib/apt/lists/*
CMD ["nginx"]