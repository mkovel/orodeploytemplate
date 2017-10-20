#!/usr/bin/env bash

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}
################################

composer install --prefer-dist --no-dev --no-interaction --working-dir=$APP_ROOT

#Migration
#php app/console oro:migration:data:load

# Recreating js css scripts
#php app/console fos:js-routing:dump
#php app/console assets:install
#php app/console oro:assets:install --symlink
#php app/console assetic:dump --no-debug
#php app/console oro:localization:dump
#php app/console oro:translation:dump
#php app/console oro:requirejs:build

# Warmup
php app/console cache:warmup

