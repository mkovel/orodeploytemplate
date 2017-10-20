#!/usr/bin/env bash

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}
################################

info "composer install"
composer config --global github-oauth.github.com 2504e51765223e2969d18b77bf526be670f76531
composer global require "fxp/composer-asset-plugin:dev-master"
composer global require hirak/prestissimo
composer install --prefer-dist --no-dev --no-interaction --working-dir=$APP_ROOT

info "php app/console oro:install"
php app/console oro:install \
  --drop-database \
  --application-url http://oro/ \
  --organization-name 'default' \
  --user-name admin \
  --user-password admin \
  --user-email admin@ttt.t \
  --user-firstname AdminF \
  --user-lastname AdminL \
  --sample-data y \
  --force \
  -v  \

php app/console oro:api:doc:cache:clear

info "Application was initiated correctly $APP_IS_INITIATED"
touch $APP_IS_INITIATED