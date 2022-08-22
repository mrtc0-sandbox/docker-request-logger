.PHONY: all build

PLUGIN_NAME = mrtc0/docker-request-logger

all: build

build:
	docker build -t ${PLUGIN_NAME}:latest .
	mkdir -p ./plugin/rootfs
	docker create --name docker-request-logger-tmp ${PLUGIN_NAME}
	docker export docker-request-logger-tmp | tar -x -C ./plugin/rootfs
	cp config.json ./plugin/
	docker rm -vf docker-request-logger-tmp

plugin/create:
	docker plugin rm -f ${PLUGIN_NAME}:latest || true
	docker plugin create ${PLUGIN_NAME}:latest ./plugin

plugin/enable:
	docker plugin enable ${PLUGIN_NAME}:latest

plugin/push:
	docker plugin push ${PLUGIN_NAME}:latest

clean:
	docker rmi ${PLUGIN_NAME}:latest
	rm -rf plugin/
