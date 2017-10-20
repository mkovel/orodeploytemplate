#!/usr/bin/env bash

function info {
    printf "\033[0;36m===> \033[0;33m${1}\033[0m\n"
}
info "docker-entrypoint.sh"
################################

# variables
APP_ROOT=${APP_ROOT:-'/var/www/site'}
export APP_ROOT=$APP_ROOT

REPO_ROOT=$APP_ROOT'_git'
export REPO_ROOT=$REPO_ROOT

APP_IS_INITIATED=$APP_ROOT'/vendor/correct_initial.tmp'
export APP_IS_INITIATED=$APP_IS_INITIATED

APP_REINSTALL=${APP_REINSTALL:-false}
APP_REPOSITORY=${APP_REPOSITORY:-false}
APP_BRANCH=${APP_BRANCH:-false}
APP_SOURCE_PATH=${APP_SOURCE_PATH:-'./'}
COMPOSER_USE=${COMPOSER_USE:-false}
COMPOSER_HOME=${COMPOSER_HOME:-$APP_ROOT/.composer}
###

info 'APP_REINSTALL='$APP_REINSTALL
if $APP_REINSTALL;
then
  find $APP_ROOT -mindepth 1 -delete
  info 'clear app folder DONE'
fi

if [ -f $APP_IS_INITIATED ]
then
  APP_INITIATED=true
else
  APP_INITIATED=false
fi
info "APP_INITIATED="$APP_INITIATED

if $APP_REPOSITORY;
then

  mkdir -p $REPO_ROOT

  if ! [ "$(ls -A $REPO_ROOT)" ];
  then
    SAFE_APP_REPOSITORY=`echo $APP_REPOSITORY | sed -e 's/\w*:\w*@/###:###@/g'`
    info "git clone --single-branch --depth 2 $SAFE_APP_REPOSITORY $REPO_ROOT "

    if ! git clone clone --single-branch --depth 2 $APP_REPOSITORY $REPO_ROOT
    then
      info "git clone ERROR"; exit;
    fi
    info "git clone OK"

    cd $REPO_ROOT
  else
    cd $REPO_ROOT

    info "git pull"
    if ! git pull
    then
      info "git pull ERROR"; exit;
    fi
    info "git pull OK"
  fi

  info "APP_BRANCH "$APP_BRANCH
  if [ ! -z "$APP_BRANCH" ];
  then
    info "git checkout "$APP_BRANCH
#    git checkout -b $APP_BRANCH origin/$APP_BRANCH
    git checkout $APP_BRANCH
  fi

  info "cp "$REPO_ROOT"/"$APP_SOURCE_PATH". "$APP_ROOT
  cp -fr $REPO_ROOT"/"$APP_SOURCE_PATH"." $APP_ROOT

  chmod -R u=rwX,g=rwX,o=rX $APP_ROOT
fi


info "run APP_CMD_PRE.sh"
bash  APP_CMD_PRE.sh

if ! $APP_INITIATED ;
then
    info "run APP_CMD_INIT.sh"
    bash  APP_CMD_INIT.sh
else
    info "run APP_CMD_UPDATE.sh"
    bash  APP_CMD_UPDATE.sh
fi

info "run APP_CMD_POST.sh"
bash  APP_CMD_POST.sh

#env > env_php.txt
exec "$@"