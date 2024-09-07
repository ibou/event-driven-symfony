.PHONY: help

env ?= dev 

## Colors
COLOR_RESET			= \033[0m
COLOR_ERROR			= \033[31m
COLOR_INFO			= \033[32m
COLOR_COMMENT		= \033[33m
COLOR_TITLE_BLOCK	= \033[0;44m\033[37m

#---SYMFONY--#
DOCKER_PHP = docker exec -it app bash
#------------#
 
DOCKER_COMPOSE = docker-compose -p php-even-driven
#---PHPUNIT-#
PHPUNIT = vendor/bin/phpunit
#------------#

## Help
help:
	@printf "${COLOR_TITLE_BLOCK}App Makefile${COLOR_RESET}\n"
	@printf "\n"
	@printf "${COLOR_COMMENT}Usage:${COLOR_RESET}\n"
	@printf " make [target]\n\n"
	@printf "${COLOR_COMMENT}Available targets:${COLOR_RESET}\n"
	@awk '/^[a-zA-Z\-\_0-9\@]+:/ { \
		helpLine = match(lastLine, /^## (.*)/); \
		helpCommand = substr($$1, 0, index($$1, ":")); \
		helpMessage = substr(lastLine, RSTART + 3, RLENGTH); \
		printf " ${COLOR_INFO}%-16s${COLOR_RESET} %s\n", helpCommand, helpMessage; \
	} \
	{ lastLine = $$0 }' $(MAKEFILE_LIST)

## launch docker containers, no rebuild
start:
	@$(DOCKER_COMPOSE) up -d --build --force-recreate --remove-orphans

## stop docker containers
stop:
	@$(DOCKER_COMPOSE) stop

## down docker containers
down:
	@$(DOCKER_COMPOSE) down

logs:
	@$(DOCKER_COMPOSE) logs -f

## stop docker containers
restart: stop start

## shell app
shell-app:
	@$(DOCKER_PHP)

## tests unit
phpunit:
	docker exec -it app composer simple-tests

domimi:
	docker exec app php bin/console database:migrations:migrate

