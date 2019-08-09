
ROOT_DIR=$(shell pwd)

builder:
	echo 'Prepare build environment...'
	@docker build -q -t unlight-client -f Dockerfile-client .

Unlight.swf:
	@docker run --rm -v ${ROOT_DIR}/assets:/assets \
									-v ${ROOT_DIR}/dist:/app/dist \
									--env-file compile.env \
									unlight-client compile-client

client: builder Unlight.swf

server:
	echo 'Prepare docker image for server...'
	@docker build -t unlight-server -f Dockerfile-server .

update:
	echo 'Starting import new game data...'
	@docker-compose run auth_server update
	@docker-compose rm -f auth_server

start: server
	@docker-compose up -d

stop:
	@docker-compose stop

db:
	@docker-compose exec db mysql -u unlight -D unlight_db -p
