FROM nginx:stable
#FROM nginx:1.13-alpine

ADD ssl/nginx.crt /etc/nginx/nginx.crt
ADD ssl/nginx.key /etc/nginx/nginx.key

ADD nginx.conf /etc/nginx/nginx.conf
ADD sites-enabled/* /etc/nginx/sites-enabled/
RUN rm /etc/nginx/conf.d/default.conf

RUN rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log



