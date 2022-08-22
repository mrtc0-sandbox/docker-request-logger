# docker-request-logger

This plugin only logs requests to the Docker API.

## Install

1. Install plugin

```shell
$ docker plugin install mrtc0/docker-request-logger:latest
```

2. Edit your docker daemon configuration and restart docker daemon.

```shell
$ cat /etc/docker/daemon.json
{
  "authorization-plugins": ["mrtc0/docker-request-logger:latest"]
}

$ sudo systemctl restart docker
```

## Development

1. Edit your docker daemon configuration.

```shell
$ cat /etc/docker/daemon.json
{
  "authorization-plugins": ["mrtc0/docker-request-logger:latest"]
}
```

2. Build and enable plugin

```shell
$ make build && make plugin/create && make plugin/enable
$ sudo systemctl restart docker
```

3. Run

```shell
$ docker run --rm hello-world

$ sudo journalctl -f -xu docker
...
Aug 22 18:37:45 x1 dockerd[622436]: time="2022-08-22T18:37:45+09:00" level=error msg="time=\"2022-08-22T09:37:45Z\" level=info msg=\"Request received\" RequestBody=\"[]\" RequestHeaders=\"map[Connection:Upgrade Content-Length:0 Content-Type:text/plain Upgrade:tcp User-Agent:Docker-Client/20.10.17 (linux)]\" RequestMethod=POST RequestPeerCertificates=\"[]\" RequestURI=\"/v1.41/containers/200626c1ebac7f076a8ef2424706df9440f987651505f5051f6955b07160252b/attach?stderr=1&stdout=1&stream=1\" ResponseBody=\"[]\" ResponseHeaders=\"map[]\" ResponseStatusCode=0 User= UserAuthNMethod=" plugin=8b73164d369f3eaa55445b161e97a5e92a1cb1be573e7e196773715ac84ad22e
...
```
