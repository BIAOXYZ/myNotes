
# 官方

Docker Engine API (v1.41) https://docs.docker.com/engine/api/v1.41/

Examples using the Docker Engine SDKs and Docker API https://docs.docker.com/engine/api/sdk/examples/
- > **List and manage containers**
  ```sh
  curl --unix-socket /var/run/docker.sock http://localhost/v1.41/containers/json
  ```
  >> 【[:star:][`*`]】 //notes：如果不修改 docker daemon 的配置的话，是不能用 http 方式的 restful api 的。只能用这种 socket 方式的。——但是其实本地试试也够用了。

## Python API

Docker SDK for Python https://github.com/docker/docker-py/

Client API https://docker-py.readthedocs.io/en/1.2.1/api/

# 其他

docker api 基本介绍和使用 https://blog.csdn.net/whatday/article/details/108396655

Docker 系列（八）：Docker API使用 https://www.cnblogs.com/-wenli/p/13621862.html
- > **如何操作docker API**
  * > 比如我们查看docker的images详细信息，就可以直接用curl 来调取：
    ```sh
    $ curl -X GET http://127.0.0.1:8088/images/json
    ```
  * > 这样显示会比较错乱无章，我们可以在命令后面加个 python -mjson.tool 格式化下
    ```sh
    $ curl -X GET http://127.0.0.1:8088/images/json | python -mjson.tool
    ```
    > 这样的结果格式就比较标准化，比较容易阅读。
    >> 【[:star:][`*`]】 //notes：如果不想改 `/usr/lib/systemd/system/docker.service` （然后重启docker），可以用下面这句：
    ```sh
    curl --unix-socket /var/run/docker.sock http://localhost/v1.38/containers/json | python -mjson.tool
    ```

Docker Remote API 如何使用？ - 知乎 https://www.zhihu.com/question/24852884

# 个人实战1

```sh
# 开始时默认的只能用 socket 方式，首先展示用这种方式进行查询的结果。
$ curl --unix-socket /var/run/docker.sock http://localhost/v1.38/containers/json | python -mjson.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   786  100   786    0     0   451k      0 --:--:-- --:--:-- --:--:--  767k
[
    {
        "Id": "650fa0e1fd4b55d827a66c1265515a89920e88706098dde9fb05675a0b617155",
        "Names": [
            "/pgdebug"
        ],
        "Image": "ubuntu:16.04",
        "ImageID": "sha256:b6f50765242581c887ff1acc2511fa2d885c52d8fb3ac8c4bba131fd86567f2e",
        "Command": "bash",
        "Created": 1638413038,
        "Ports": [],
        "Labels": {},
        "State": "running",
        "Status": "Up 4 months",
        "HostConfig": {
            "NetworkMode": "default"
        },
        "NetworkSettings": {
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "a7fd9a9f30a5e057254fdcdc854dae7677e6200605a67b7c2b26711777e61171",
                    "EndpointID": "9da7627f0fa80be10abbd7c1eaf8e7d92f02f821d7465ec031e5b320b93d7b87",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        },
        "Mounts": []
    }
]
$

# 此时如果想用 http 方式的 restful api，就需要修改 docker daemon 的配置。否则，就是如下结果：
$ curl -X GET http://127.0.0.1:9099/containers/json | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0curl: (7) Failed to connect to 127.0.0.1 port 9099: Connection refused
Expecting value: line 1 column 1 (char 0)

# 那么接下来就是修改 docker daemon 的配置。其配置文件因不同系统的原因各不相同，
# Debian 9 是在： /lib/systemd/system/docker.service
# 此外，原来那一行的内容是： ExecStart=/usr/bin/dockerd -H fd://
# 我们改为： ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:9099
$ vi /lib/systemd/system/docker.service
$ systemctl daemon-reload
$ systemctl restart docker

$ curl -X GET http://127.0.0.1:9099/containers/json
[{"Id":"650fa0e1fd4b55d827a66c1265515a89920e88706098dde9fb05675a0b617155","Names":["/pgdebug"],"Image":"ubuntu:16.04","ImageID":"sha256:b6f50765242581c887ff1acc2511fa2d885c52d8fb3ac8c4bba131fd86567f2e","Command":"bash","Created":1638413038,"Ports":[],"Labels":{},"State":"running","Status":"Up 4 months","HostConfig":{"NetworkMode":"default"},"NetworkSettings":{"Networks":{"bridge":{"IPAMConfig":null,"Links":null,"Aliases":null,"NetworkID":"a7fd9a9f30a5e057254fdcdc854dae7677e6200605a67b7c2b26711777e61171","EndpointID":"9da7627f0fa80be10abbd7c1eaf8e7d92f02f821d7465ec031e5b320b93d7b87","Gateway":"172.17.0.1","IPAddress":"172.17.0.2","IPPrefixLen":16,"IPv6Gateway":"","GlobalIPv6Address":"","GlobalIPv6PrefixLen":0,"MacAddress":"02:42:ac:11:00:02","DriverOpts":null}}},"Mounts":[]}]
$
$ curl -X GET http://127.0.0.1:9099/containers/json | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   786  100   786    0     0   437k      0 --:--:-- --:--:-- --:--:--  767k
[
    {
        "Id": "650fa0e1fd4b55d827a66c1265515a89920e88706098dde9fb05675a0b617155",
        "Names": [
            "/pgdebug"
        ],
        "Image": "ubuntu:16.04",
        "ImageID": "sha256:b6f50765242581c887ff1acc2511fa2d885c52d8fb3ac8c4bba131fd86567f2e",
        "Command": "bash",
        "Created": 1638413038,
        "Ports": [],
        "Labels": {},
        "State": "running",
        "Status": "Up 4 months",
        "HostConfig": {
            "NetworkMode": "default"
        },
        "NetworkSettings": {
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "a7fd9a9f30a5e057254fdcdc854dae7677e6200605a67b7c2b26711777e61171",
                    "EndpointID": "9da7627f0fa80be10abbd7c1eaf8e7d92f02f821d7465ec031e5b320b93d7b87",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        },
        "Mounts": []
    }
]
$
```
```sh
#// !!!!!注意，下面的语句是在远端（一台 Mac）执行的，而不是在有 Docker Daemon 的 Linux 机器上直接执行的。

# 此外，在个人笔记本（Mac）上的 Chrome 浏览器里用 PostWoman 之类的插件（Postman不知道为啥不能用了。。。），
## 去 GET 这个 api 也可以查出结果： http://{Linux_IP_Where_Docker_Daemon_Runs}:9099/containers/json
## 但是那样的话结果是在浏览器里显示，截图不好展示，于是就在 Mac 默认的终端里用 curl 来查，并展示结果了。

$ curl -X GET http://{Linux_IP_Where_Docker_Daemon_Runs}:9099/containers/json | python -m json.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   786  100   786    0     0   1144      0 --:--:-- --:--:-- --:--:--  1142
[
    {
        "Id": "650fa0e1fd4b55d827a66c1265515a89920e88706098dde9fb05675a0b617155",
        "Names": [
            "/pgdebug"
        ],
        "Image": "ubuntu:16.04",
        "ImageID": "sha256:b6f50765242581c887ff1acc2511fa2d885c52d8fb3ac8c4bba131fd86567f2e",
        "Command": "bash",
        "Created": 1638413038,
        "Ports": [],
        "Labels": {},
        "State": "running",
        "Status": "Up 4 months",
        "HostConfig": {
            "NetworkMode": "default"
        },
        "NetworkSettings": {
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "a7fd9a9f30a5e057254fdcdc854dae7677e6200605a67b7c2b26711777e61171",
                    "EndpointID": "9da7627f0fa80be10abbd7c1eaf8e7d92f02f821d7465ec031e5b320b93d7b87",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        },
        "Mounts": []
    }
]
```
