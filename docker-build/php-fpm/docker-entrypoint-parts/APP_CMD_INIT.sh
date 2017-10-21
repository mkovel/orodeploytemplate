#!/usr/bin/env bash

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}
################################

params_yml="app/config/parameters.yml"
params_dist_yml="app/config/parameters.yml.dist"
if [ ! -f $params_yml ];
then
  info "rewrite DB permissions in app/config/parameters.yml"
  sed -i -e 's|database_host:.*|database_host: '$SYMFONY__MYSQL_HOST'|g' $params_dist_yml
  sed -i -e 's|database_name:.*|database_name: '$SYMFONY__MYSQL_DATABASE'|g' $params_dist_yml
  sed -i -e 's|database_user:.*|database_user: '$SYMFONY__MYSQL_USER'|g' $params_dist_yml
  sed -i -e 's|database_password:.*|database_password: '$SYMFONY__MYSQL_PASSWORD'|g' $params_dist_yml
fi

info "composer install"
composer config --global github-oauth.github.com $COMPOSER_GITHUB_TOKEN
composer global require "fxp/composer-asset-plugin:dev-master"
composer global require hirak/prestissimo
composer install --prefer-dist --no-dev --no-interaction --working-dir=$APP_ROOT

info "php app/console oro:install"
php app/console oro:install \
  --drop-database \
  --application-url http://oro/ \
  --organization-name 'Organization' \
  --user-name admin \
  --user-password admin \
  --user-email admin@example.com \
  --user-firstname AdminF \
  --user-lastname AdminL \
  --sample-data y \
  --timeout 10000 \
  -vv \

php app/console oro:api:doc:cache:clear

info "Application was initiated correctly $APP_IS_INITIATED"
touch $APP_IS_INITIATED