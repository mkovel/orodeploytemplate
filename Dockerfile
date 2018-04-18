FROM alpine
#FROM alpine:3.7

RUN apk update
RUN apk add bash
RUN rm -rf /var/cache/apk/*

ARG APP_ROOT=/var/www/site

COPY ./source_code $APP_ROOT

WORKDIR /var/www/site

CMD ["tail", "-f", "/dev/null"]
