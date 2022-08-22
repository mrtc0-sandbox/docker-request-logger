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
Aug 22 18:48:14 x1 dockerd[646286]: time="2022-08-22T18:48:14+09:00" level=error msg="time=\"2022-08-22T09:48:14Z\" level=info msg=\"Request received\" request_body= request_headers=\"map[User-Agent:Docker-Client/20.10.17 (linux)]\" request_method=HEAD request_uri=/_ping user= user_authn_method=" plugin=ecf68d51e51120bc6bdcf8973d6fb587a76a3d440eb877d68d2ab997a6e9fb46
Aug 22 18:48:14 x1 dockerd[646286]: time="2022-08-22T18:48:14+09:00" level=error msg="time=\"2022-08-22T09:48:14Z\" level=info msg=\"Request received\" request_body=\"{\\\"Hostname\\\":\\\"\\\",\\\"Domainname\\\":\\\"\\\",\\\"User\\\":\\\"\\\",\\\"AttachStdin\\\":false,\\\"AttachStdout\\\":true,\\\"AttachStderr\\\":true,\\\"Tty\\\":false,\\\"OpenStdin\\\":false,\\\"StdinOnce\\\":false,\\\"Env\\\":null,\\\"Cmd\\\":null,\\\"Image\\\":\\\"hello-world\\\",\\\"Volumes\\\":{},\\\"WorkingDir\\\":\\\"\\\",\\\"Entrypoint\\\":null,\\\"OnBuild\\\":null,\\\"Labels\\\":{},\\\"HostConfig\\\":{\\\"Binds\\\":null,\\\"ContainerIDFile\\\":\\\"\\\",\\\"LogConfig\\\":{\\\"Type\\\":\\\"\\\",\\\"Config\\\":{}},\\\"NetworkMode\\\":\\\"default\\\",\\\"PortBindings\\\":{},\\\"RestartPolicy\\\":{\\\"Name\\\":\\\"no\\\",\\\"MaximumRetryCount\\\":0},\\\"AutoRemove\\\":true,\\\"VolumeDriver\\\":\\\"\\\",\\\"VolumesFrom\\\":null,\\\"CapAdd\\\":null,\\\"CapDrop\\\":null,\\\"CgroupnsMode\\\":\\\"\\\",\\\"Dns\\\":[],\\\"DnsOptions\\\":[],\\\"DnsSearch\\\":[],\\\"ExtraHosts\\\":null,\\\"GroupAdd\\\":null,\\\"IpcMode\\\":\\\"\\\",\\\"Cgroup\\\":\\\"\\\",\\\"Links\\\":null,\\\"OomScoreAdj\\\":0,\\\"PidMode\\\":\\\"\\\",\\\"Privileged\\\":false,\\\"PublishAllPorts\\\":false,\\\"ReadonlyRootfs\\\":false,\\\"SecurityOpt\\\":null,\\\"UTSMode\\\":\\\"\\\",\\\"UsernsMode\\\":\\\"\\\",\\\"ShmSize\\\":0,\\\"ConsoleSize\\\":[0,0],\\\"Isolation\\\":\\\"\\\",\\\"CpuShares\\\":0,\\\"Memory\\\":0,\\\"NanoCpus\\\":0,\\\"CgroupParent\\\":\\\"\\\",\\\"BlkioWeight\\\":0,\\\"BlkioWeightDevice\\\":[],\\\"BlkioDeviceReadBps\\\":null,\\\"BlkioDeviceWriteBps\\\":null,\\\"BlkioDeviceReadIOps\\\":null,\\\"BlkioDeviceWriteIOps\\\":null,\\\"CpuPeriod\\\":0,\\\"CpuQuota\\\":0,\\\"CpuRealtimePeriod\\\":0,\\\"CpuRealtimeRuntime\\\":0,\\\"CpusetCpus\\\":\\\"\\\",\\\"CpusetMems\\\":\\\"\\\",\\\"Devices\\\":[],\\\"DeviceCgroupRules\\\":null,\\\"DeviceRequests\\\":null,\\\"KernelMemory\\\":0,\\\"KernelMemoryTCP\\\":0,\\\"MemoryReservation\\\":0,\\\"MemorySwap\\\":0,\\\"MemorySwappiness\\\":-1,\\\"OomKillDisable\\\":false,\\\"PidsLimit\\\":0,\\\"Ulimits\\\":null,\\\"CpuCount\\\":0,\\\"CpuPercent\\\":0,\\\"IOMaximumIOps\\\":0,\\\"IOMaximumBandwidth\\\":0,\\\"MaskedPaths\\\":null,\\\"ReadonlyPaths\\\":null},\\\"NetworkingConfig\\\":{\\\"EndpointsConfig\\\":{}},\\\"Platform\\\":null}\\n\" request_headers=\"map[Content-Length:1533 Content-Type:application/json User-Agent:Docker-Client/20.10.17 (linux)]\" request_method=POST request_uri=/v1.41/containers/create user= user_authn_method=" plugin=ecf68d51e51120bc6bdcf8973d6fb587a76a3d440eb877d68d2ab997a6e9fb46
...
```
