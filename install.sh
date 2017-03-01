#!/usr/bin/env bash
######  GITHUB REPO  ########
#APP_VERSION="2.0.2"
#APP_REPOSITORY="https://github.com/orocrm/platform-application"

#APP_VERSION="1.0"
#APP_REPOSITORY="https://github.com/orocommerce/orocommerce-application.git"

#APP_VERSION="2.0.2"
#APP_REPOSITORY="https://github.com/orocrm/crm-application.git"
#################


#APP_FOLDER="./oro"
#APP_WWW="/var/www"
#COMPOSER_HOME="$APP_WWW/.composer"

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}

rm -rf ./source-code
info 'docker-compose START'
docker-compose stop
docker-compose build --force-rm
docker-compose up -d
info '### docker-compose END'

###########  BEGIN
DPE="docker-compose exec php"
DPEW="docker-compose exec --user www-data php"

$DPE bash -c "chown -R www-data:www-data \$APP_WWW"

info 'Github repo clone'
$DPEW bash -c "git clone -b \$APP_VERSION \$APP_REPOSITORY \$APP_FOLDER"

info 'Composer install'
$DPEW bash -c "\
  mkdir -p \$COMPOSER_HOME \
  && chmod -R 777 \$COMPOSER_HOME \
  && cd \$APP_FOLDER \
  && curl -sS https://getcomposer.org/installer | php \
  && php composer.phar global require fxp/composer-asset-plugin:dev-master \
  && php -d memory_limit=-1 composer.phar install --prefer-dist --no-dev --no-interaction --verbose
"
###  && php -d memory_limit=-1 composer.phar require fxp/composer-asset-plugin:1.2.2 

$DPEW bash -c "\
  cd \$APP_FOLDER \
  && sed -i -e 's|database_host:.*|database_host: '\$MYSQL_HOST'|g' app/config/parameters.yml \
  && sed -i -e 's|database_name:.*|database_name: '\$MYSQL_DATABASE'|g' app/config/parameters.yml \
"

#  && rm -r app/cache \
info 'oro:install'
$DPEW bash -c "\
  cd \$APP_FOLDER \
  && php app/console oro:install --force --drop-database --env=prod \
  --application-url http://oro/ \
  --organization-name 'Oro Template' \
  --user-name admin \
  --user-password admin \
  --user-email admin@example.tt \
  --user-firstname AdminF \
  --user-lastname AdminL \
  --sample-data y
"

info 'oro:api:doc:cache:clear'
$DPEW bash -c "\
  cd \$APP_FOLDER \
  && php app/console oro:api:doc:cache:clear
"
