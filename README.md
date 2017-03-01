## Universal docker-compose template for quick unfolding of different ORO applications

#### orocrm/platform-application
https://github.com/orocrm/platform-application

#### crm-application
https://github.com/orocrm/crm-application

#### orocommerce/orocommerce-application
https://github.com/orocommerce/orocommerce-application

Steps:
1. Set uniq container prefix for your poject in file .env COMPOSE_PROJECT_NAME=""
2. Set value for your APP_VERSION and APP_REPOSITORY variables in docker-compose.yml 

##  ORO GITHUB REPOSITORIES
APP_VERSION="2.0.2"
APP_REPOSITORY="https://github.com/orocrm/platform-application"

APP_VERSION="1.0"
APP_REPOSITORY="https://github.com/orocommerce/orocommerce-application.git"

APP_VERSION="2.0.2"
APP_REPOSITORY="https://github.com/orocrm/crm-application.git"
