#!/usr/bin/env bash

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}
################################

info "preparing directories"
mkdir -p app/cache
mkdir -p app/logs
mkdir -p web/media
mkdir -p app/attachment

##HTTPDUSER=`ps axo user,comm | grep -E '[a]pache|[h]ttpd|[_]www|[w]ww-data|[n]ginx' | grep -v root | head -1 | cut -d\  -f1`
HTTPDUSER="www-data"
info "set up symfony2 folders permissions for $HTTPDUSER"
setfacl  -R -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX app/cache app/logs web/media app/attachment
setfacl -dR -m u:"$HTTPDUSER":rwX -m u:`whoami`:rwX app/cache app/logs web/media app/attachment
