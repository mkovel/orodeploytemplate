# Oro application docker-compose template
Universal, ready-to-use, fully functional `docker-compose` template for quick unfolding of different ORO platform / crm / commerce applications 


- [Preparation](#preparation)
- [Use `development`](#use-development)
- [Use `production`](#use-production)
- [ORO repositories](#oro-application-repositories)
- [Description of .etc variables](#description-of-etc-variables)

### Preparation
1. Clone this repo
```
git clone --depth 3 https://github.com/mkovel/orodeploytemplate.git
cd orodeploytemplate
```
2. Select oro application repo from - [ORO repositories](#ORO repositories) and clone one of them to ./source_code
```
rm ./source_code/.gitkeep
git clone  --single-branch --depth 3 https://github.com/orocrm/platform-application ./source_code
git checkout -b 2.4.2
```
3. Copy .env_dist to .env and set up value for variables. See [Description of .etc variables](#description-of-etc-variables) for clarification
4. Fill in your GITHUB Personal access tokens. Use COMPOSER_GITHUB_TOKEN variable in file **.env** 
https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/   

### Use `development`
run/install application
```
docker-compose -f docker-compose-dev.yml build
docker-compose -f docker-compose-dev.yml up -d
```
updating application
```
docker-compose -f docker-compose-dev.yml down
##update yours source code in ./source_code
docker-compose -f docker-compose-dev.yml up -d
```

Url for checking
https://localhost:444

```
login:admin
pass:admin
```

### Use `production`
``` 
### in plans
```


### ORO application repositories
```
#OroPlarform application
APP_REPOSITORY="https://github.com/orocrm/platform-application"
APP_BRANCH="2.4.2"

#OroCrm application
APP_REPOSITORY="https://github.com/orocrm/crm-application.git"
APP_BRANCH="2.0.2"

#OroCommerce application
APP_REPOSITORY="https://github.com/orocommerce/orocommerce-application.git"
APP_BRANCH="1.0"
```

### Description of .etc variables 

* `COMPOSE_PROJECT_NAME=proj1` - if you already use the same, change `proj1` to a different docker project name 
* `MYSQL_HOST=db` - name of mysql docker service(container) 
* `MYSQL_PORT=3306` - mysql port
* `MYSQL_DATABASE=prj_db` - database name  
* `MYSQL_USER=user` - user name  
* `MYSQL_PASSWORD=pass` - user pass 
* `MYSQL_ROOT_HOST=%` -  
* `MYSQL_ALLOW_EMPTY_PASSWORD=yes` -  
* `MYSQL_ROOT_PASSWORD=root` -  
* `APP_ROOT=/var/www/site` - internal application location
* `CHECK_READY_DELAY=120` -
* `CHECK_READY_HOST=https://nginx` -
* `COMPOSER_HOME=/var/www/.composer` -
* `COMPOSER_GITHUB_TOKEN=2504e51765223e2969d18b77bf526be670f76531` -
* `APP_SESSION_HANDLER=snc_redis.session.handler` - Symfony session handler
* `REDIS_PASS=redis` -
* `REDIS_SESSION=redis://redis@redis:6379/1` -
* `REDIS_DOCTRINE=redis://redis@redis:6379/2` -
* `REDIS_TTL=600` -
* `APP_MAILER_TRANSPORT=smtp` -
* `APP_MAILER_PORT=465` -
* `APP_MAILER_ENCRYPTION=ssl` -
* `APP_MAILER_HOST=smtp.gmail.com` -
* `APP_MAILER_USER=test@gmail.com` -
* `APP_MAILER_PASSWORD=testpass` -
