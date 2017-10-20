#!/usr/bin/env bash

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}
info "docker-entrypoint.sh"
################################

# rewritable variables
CHECK_READY_DELAY=${CHECK_READY_DELAY:-10}
CHECK_READY_HOST=${CHECK_READY_HOST:-false}
APP_ROOT=${APP_ROOT:-'/var/www/site'}
export APP_ROOT
APP_SUPERVISOR_LOGS=${APP_SUPERVISOR_LOGS:-$APP_ROOT'/app/logs/supervisor/'}
export APP_SUPERVISOR_LOGS=$APP_SUPERVISOR_LOGS
###

info "create logs dir"
mkdir -p $APP_SUPERVISOR_LOGS
HTTPDUSER="www-data"
setfacl  -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX $APP_SUPERVISOR_LOGS

while ! httping -q -c1 -s -G -g $CHECK_READY_HOST ;
do
  info "$CHECK_READY_HOST is not available, wait $CHECK_READY_DELAY sec"
  sleep $CHECK_READY_DELAY;
done

(crontab -l ; echo "*/1 * * * * /var/www/site/app/console oro:cron") | crontab -

#env > env_bgtasks.txt
exec "$@"
