# Project Setting
ROOT_DIR=$(shell pwd)
-include server.env

.PHONY: server client

builder:
	@echo 'Prepare build environment...'
	@docker build -t openunlight/legacy-builder -f client/Dockerfile .

Unlight.swf:
	@docker run --rm -v ${ROOT_DIR}/assets:/assets \
									-v ${ROOT_DIR}/dist:/app/dist \
									-v ${ROOT_DIR}/fonts:/app/fonts \
									--env-file compile.env \
									openunlight/legacy-builder compile-client

client: builder Unlight.swf

server:
	@echo 'Prepare docker image for server...'
	@docker build -t openunlight/legacy-server -f server/Dockerfile .

update:
	@echo 'Starting import new game data...'
	@bin/unlight up -d db memcached
	@bin/unlight run auth_server update
	@bin/unlight rm -f auth_server

setup: server update

start:
	@bin/unlight up -d --scale db=${ENABLE_DB} \
										 --scale memcached=${ENABLE_MEMCACHED}

restart:
	@bin/unlight restart

stop:
	@bin/unlight stop

mysql:
	@bin/unlight exec db mysql -u ${MYSQL_USER} -D ${MYSQL_DATABASE} -p
