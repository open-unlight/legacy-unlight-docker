
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
