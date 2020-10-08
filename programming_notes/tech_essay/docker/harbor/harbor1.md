
# 1.由于之前有docker官方的registry，再安装harbor时造成的问题及其解决。

```sh
#// 1.如果之前尝试过docker官方的registry，那么安装harbor最后启动时会出现容器名字冲突，报错信息大概如下：

``
ERROR: for registry  Cannot create container for service registry: Conflict. The container name "/registry" is already in use by container "88bcb59e304ed0eedb9ec05c9cf3590771de38f45452e0e7be4aabbbf37c68a1". You have to remove (or rename) that container to be able to reuse that name.

ERROR: for registry  Cannot create container for service registry: Conflict. The container name "/registry" is already in use by container "88bcb59e304ed0eedb9ec05c9cf3590771de38f45452e0e7be4aabbbf37c68a1". You have to remove (or rename) that container to be able to reuse that name.
ERROR: Encountered errors while bringing up the project.
``

解决方法很简单：docker stop registry && docker container rm registry
然后再次执行harbor安装脚本即可。
```

```sh
#// 2.Harbor（的nginx）需要监听的80端口冲突

[root@scraps-inf harbor]#
[root@scraps-inf harbor]# ./install.sh

[Step 0]: checking installation environment ...

Note: docker version: 19.03.13

Note: docker-compose version: 1.18.0

[Step 1]: loading Harbor images ...
Loaded image: goharbor/redis-photon:v1.9.1
Loaded image: goharbor/registry-photon:v2.7.1-patch-2819-2553-v1.9.1
Loaded image: goharbor/harbor-registryctl:v1.9.1
Loaded image: goharbor/clair-photon:v2.0.9-v1.9.1
Loaded image: goharbor/harbor-migrator:v1.9.1
Loaded image: goharbor/chartmuseum-photon:v0.9.0-v1.9.1
Loaded image: goharbor/prepare:v1.9.1
Loaded image: goharbor/harbor-db:v1.9.1
Loaded image: goharbor/notary-server-photon:v0.6.1-v1.9.1
Loaded image: goharbor/harbor-jobservice:v1.9.1
Loaded image: goharbor/nginx-photon:v1.9.1
Loaded image: goharbor/notary-signer-photon:v0.6.1-v1.9.1
Loaded image: goharbor/harbor-portal:v1.9.1
Loaded image: goharbor/harbor-core:v1.9.1
Loaded image: goharbor/harbor-log:v1.9.1


[Step 2]: preparing environment ...
prepare base dir is set to /root/offline/harbor
Clearing the configuration file: /config/log/logrotate.conf
Clearing the configuration file: /config/log/rsyslog_docker.conf
Clearing the configuration file: /config/nginx/nginx.conf
Clearing the configuration file: /config/core/env
Clearing the configuration file: /config/core/app.conf
Clearing the configuration file: /config/registry/config.yml
Clearing the configuration file: /config/registryctl/env
Clearing the configuration file: /config/registryctl/config.yml
Clearing the configuration file: /config/db/env
Clearing the configuration file: /config/jobservice/env
Clearing the configuration file: /config/jobservice/config.yml
Generated configuration file: /config/log/logrotate.conf
Generated configuration file: /config/log/rsyslog_docker.conf
Generated configuration file: /config/nginx/nginx.conf
Generated configuration file: /config/core/env
Generated configuration file: /config/core/app.conf
Generated configuration file: /config/registry/config.yml
Generated configuration file: /config/registryctl/env
Generated configuration file: /config/db/env
Generated configuration file: /config/jobservice/env
Generated configuration file: /config/jobservice/config.yml
loaded secret from file: /secret/keys/secretkey
Generated configuration file: /compose_location/docker-compose.yml
Clean up the input dir


Note: stopping existing Harbor instance ...
Stopping registryctl   ... done
Stopping redis         ... done
Stopping harbor-db     ... done
Stopping harbor-portal ... done
Stopping harbor-log    ... done
Removing registryctl   ... done
Removing redis         ... done
Creating harbor-log ... done
Removing harbor-portal ... done
Removing harbor-log    ... done
Removing network harbor_harbor

Creating harbor-db ... done
Creating harbor-core ... done
Creating network "harbor_harbor" with the default driver
Creating nginx ... error
Creating harbor-portal ...
Creating harbor-db ...
Creating harbor-jobservice ... done
Creating registry ...
Creating redis ...
Creating harbor-core ...
Creating harbor-jobservice ...
Creating nginx ...

ERROR: for nginx  Cannot start service proxy: driver failed programming external connectivity on endpoint nginx (7b6b2d2c6072ccfb7974c4e7df6307321a8433696c419da54ea570f30807911a): Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use

ERROR: for proxy  Cannot start service proxy: driver failed programming external connectivity on endpoint nginx (7b6b2d2c6072ccfb7974c4e7df6307321a8433696c419da54ea570f30807911a): Error starting userland proxy: listen tcp 0.0.0.0:80: bind: address already in use
ERROR: Encountered errors while bringing up the project.
[root@scraps-inf harbor]#
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# netstat -antlp | grep 80
-bash: netstat: command not found
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# ss -antlp | grep 80
LISTEN    0         3000               0.0.0.0:80               0.0.0.0:*        users:(("haproxy",pid=6422,fd=11))  
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# vi harbor.yml
[root@scraps-inf harbor]# diff harbor.yml harbor.ymlbak
5c5
< hostname: 9.30.138.102
---
> hostname: reg.mydomain.com
10c10
<   port: 81
---
>   port: 80
22c22
< # external_url: https://9.30.138.102:8433
---
> # external_url: https://reg.mydomain.com:8433
[root@scraps-inf harbor]#


#// 再次执行./install.sh安装成功，并且可以看到监听的端口从80变成了81。
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker-compose ps
      Name                     Command               State             Ports
--------------------------------------------------------------------------------------
harbor-core         /harbor/harbor_core              Up
harbor-db           /docker-entrypoint.sh            Up      5432/tcp
harbor-jobservice   /harbor/harbor_jobservice  ...   Up
harbor-log          /bin/sh -c /usr/local/bin/ ...   Up      127.0.0.1:1514->10514/tcp
harbor-portal       nginx -g daemon off;             Up      8080/tcp
nginx               nginx -g daemon off;             Up      0.0.0.0:81->8080/tcp
redis               redis-server /etc/redis.conf     Up      6379/tcp
registry            /entrypoint.sh /etc/regist ...   Up      5000/tcp
registryctl         /harbor/start.sh                 Up
[root@scraps-inf harbor]#
```

## 1.1 harbor安装起来后，使用非默认的80端口时，镜像相关操作的问题及其解决。

```sh
#// 由于监听的端口不是默认的80了，docker的Insecure Registry配置也得变。
#// 如果没有改默认监听端口这个事，以前应该是这么配的（尽量用数字IP，用hostname在工行项目踩过坑- -）
#// 但是你会发现命令行登陆不了。
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker info
...
...
...
 Insecure Registries:
  9.30.138.102
  127.0.0.0/8
...
...
...
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker login 9.30.138.102 -u admin -p Harbor12345
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
Error response from daemon: login attempt to http://9.30.138.102/v2/ failed with status: 503 Service Unavailable
[root@scraps-inf harbor]#


#// 后来终于发现应该需要把带81端口的IP加进去才行。因为试了试开个VNC然后从firefox登陆的话，
#// 直接在浏览器输入 9.30.138.102 是不行的，必须输入 9.30.138.102:81。
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker-compose stop
Stopping harbor-jobservice ... done
Stopping nginx             ... done
Stopping harbor-core       ... done
Stopping registry          ... done
Stopping harbor-db         ... done
Stopping harbor-portal     ... done
Stopping registryctl       ... done
Stopping redis             ... done
Stopping harbor-log        ... done
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# vi /etc/docker/daemon.json
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# systemctl daemon-reload
[root@scraps-inf harbor]# systemctl restart docker
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker info
...
...
...
 Insecure Registries:
  9.30.138.102:81
  9.30.138.102
  9.30.138.102:5000
  127.0.0.0/8
...
...
...
[root@scraps-inf harbor]# docker-compose up -d
harbor-log is up-to-date
Starting harbor-db ...
registry is up-to-date
redis is up-to-date
registryctl is up-to-date
Starting harbor-db ... done
Starting harbor-core ... done
Starting harbor-jobservice ...
Starting harbor-jobservice ... done
[root@scraps-inf harbor]#
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker login 9.30.138.102:81 -u admin -p Harbor12345
WARNING! Using --password via the CLI is insecure. Use --password-stdin.
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
[root@scraps-inf harbor]#


#// 然后就是下面四个image到底那个才是对的呢？也就是可以被成功push的。
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker images | grep 9.30.138.102
9.30.138.102/library/my-ubuntu      latest                          c871c45b1573        8 days ago          127MB
9.30.138.102/my-ubuntu              latest                          c871c45b1573        8 days ago          127MB
9.30.138.102:81/library/my-ubuntu   latest                          c871c45b1573        8 days ago          127MB
9.30.138.102:81/my-ubuntu           latest                          c871c45b1573        8 days ago          127MB
[root@scraps-inf harbor]#

#// 事实证明如果改了端口的情况下，端口不能少。由于harbor本身的原因，默认库名称library也不能少（当然这个自己可以建别的）。
#// 所以其实只有下面四次push中最后那个能被成功push。但这里主要想强调的是：改了端口的情况下，image的tag里也得在网址后面体现出来端口。
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker push 9.30.138.102/my-ubuntu
The push refers to repository [9.30.138.102/my-ubuntu]
c5c475553a38: Retrying in 1 second
3a75fb064412: Retrying in 1 second
1785a10dd238: Retrying in 1 second
7485cb8e2447: Retrying in 1 second
received unexpected HTTP status: 503 Service Unavailable
[root@scraps-inf harbor]#
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker push 9.30.138.102:81/my-ubuntu
The push refers to repository [9.30.138.102:81/my-ubuntu]
c5c475553a38: Retrying in 1 second
3a75fb064412: Retrying in 1 second
1785a10dd238: Retrying in 1 second
7485cb8e2447: Retrying in 1 second
received unexpected HTTP status: 500 Internal Server Error
[root@scraps-inf harbor]#
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker push 9.30.138.102/library/my-ubuntu
The push refers to repository [9.30.138.102/library/my-ubuntu]
c5c475553a38: Retrying in 1 second
3a75fb064412: Retrying in 1 second
1785a10dd238: Retrying in 1 second
7485cb8e2447: Retrying in 1 second
received unexpected HTTP status: 503 Service Unavailable
[root@scraps-inf harbor]#
[root@scraps-inf harbor]#
[root@scraps-inf harbor]#
[root@scraps-inf harbor]# docker push 9.30.138.102:81/library/my-ubuntu
The push refers to repository [9.30.138.102:81/library/my-ubuntu]
c5c475553a38: Pushed
3a75fb064412: Pushed
1785a10dd238: Pushed
7485cb8e2447: Pushed
latest: digest: sha256:597d7000627f51d5b214def45cb6dc70dd5153350c7dcf4a026ceeb701802780 size: 1150
[root@scraps-inf harbor]#
```
