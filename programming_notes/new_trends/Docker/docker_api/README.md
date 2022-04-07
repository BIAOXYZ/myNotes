
# 官方

Docker Engine API (v1.41) https://docs.docker.com/engine/api/v1.41/

Examples using the Docker Engine SDKs and Docker API https://docs.docker.com/engine/api/sdk/examples/
- > **List and manage containers**
  ```sh
  curl --unix-socket /var/run/docker.sock http://localhost/v1.41/containers/json
  ```
  >> 【[:star:][`*`]】 //notes：如果不修改 docker daemon 的配置的话，是不能用 http 方式的 restful api 的。只能用这种 socket 方式的。——但是其实本地试试也够用了。

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

# 个人实战

```sh
# 开始时只能用 socket 时。
$ curl --unix-socket /var/run/docker.sock http://localhost/v1.38/containers/json | python -mjson.tool
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   783    0   783    0     0  71181      0 --:--:-- --:--:-- --:--:-- 78300
[
    {
        "Id": "409d5c05d57586787c89824df1c3d62d0e122371c8d4435c7d89b37b7f0b0071",
        "Names": [
            "/mac11"
        ],
        "Image": "buildimage:v1",
        "ImageID": "sha256:2befe0524250680522ccbd4d77d87fb1ad62e6bc5025827bf2e2c7b163b269be",
        "Command": "bash",
        "Created": 1649058183,
        "Ports": [],
        "Labels": {},
        "State": "running",
        "Status": "Up 2 days",
        "HostConfig": {
            "NetworkMode": "default"
        },
        "NetworkSettings": {
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "b9155aac42183b893c0ba7a0297811af90611ba82d14380d2fe4f2e5d987bace",
                    "EndpointID": "5f42a9676c1821debaea1bcc2aab76a9dcbfb2d78402b4c8efa4fac7ad5946d8",
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
