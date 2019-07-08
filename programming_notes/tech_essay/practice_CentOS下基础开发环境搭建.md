
# Docker and Docker Compose

虽然安装docker方法很多，但是还是推荐用《Docker — 从入门到实践》里的办法：
- CentOS 安装 Docker CE https://yeasy.gitbooks.io/docker_practice/content/install/centos.html
- Docker Compose 项目 -- 安装与卸载 https://yeasy.gitbooks.io/docker_practice/content/compose/install.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker安装

- 卸载旧版本
```
未执行，因为是新的虚拟机
```

- 使用 yum 安装
```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo

sudo yum makecache fast

sudo yum install docker-ce
```

- 启动 Docker CE
```
// sudo systemctl enable docker
// sudo systemctl start docker

未执行，应该是现在新版默认安装完就启动 
```

```
2019.02.26更新：看来并非任何机器和系统都如此，刚才就碰到了需要启动docker服务的情况。
注意刚安装完不启动docker服务的话执行docker version时候那句报错：
"Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?"
----------------------------------------------------------------------------------------------------

Dependency Updated:
  policycoreutils.x86_64 0:2.5-29.el7_6.1

Complete!
[root@cloudsec1 ~]# docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        6247962
 Built:             Sun Feb 10 04:13:27 2019
 OS/Arch:           linux/amd64
 Experimental:      false
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
[root@cloudsec1 ~]# systemctl start docker
[root@cloudsec1 ~]# docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        6247962
 Built:             Sun Feb 10 04:13:27 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 03:47:25 2019
  OS/Arch:          linux/amd64
  Experimental:     false
```

- 建立 docker 用户组
```
sudo groupadd docker

// sudo usermod -aG docker $USER
sudo usermod -aG docker test2  
```

```
不把普通用户（例如此处的openshift1）加进docker用户组就执行docker命令的话会报如下错误：
"Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get 
http://%2Fvar%2Frun%2Fdocker.sock/v1.39/version: dial unix /var/run/docker.sock: connect: permission denied"
----------------------------------------------------------------------------------------------------

[openshift1@cloudsec1 ~]$ docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        6247962
 Built:             Sun Feb 10 04:13:27 2019
 OS/Arch:           linux/amd64
 Experimental:      false
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.39/version: dial unix /var/run/docker.sock: connect: permission denied

[openshift1@cloudsec1 ~]$ groups openshift1
openshift1 : openshift1

[root@cloudsec1 ~]# groupadd docker
groupadd: group 'docker' already exists
[root@cloudsec1 ~]# usermod -aG docker openshift1
[root@cloudsec1 ~]#

[openshift1@cloudsec1 ~]$ groups openshift1
openshift1 : openshift1 docker

--> Then user "openshift1" exit and login // openshift1用户退出再登陆一下

[openshift1@cloudsec1 ~]$ docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        6247962
 Built:             Sun Feb 10 04:13:27 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 03:47:25 2019
  OS/Arch:          linux/amd64
  Experimental:     false
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker升级

背景是有个openshift的单节点环境，因为安装的时候按攻略里只安了`1.13`版本的docker（也就是最低的足够用的版本），后面有些新版本才有的功能就用不了，于是想着升级一下docker版本。但是又怕影响openshift环境——因为网上大多数给的办法都是**先卸载已有docker，再安装新版本docker**来升级。这个帖子里【[Upgrade docker on CentOS 7](https://stackoverflow.com/questions/26472586/upgrade-docker-on-centos-7)】有提到这样升级可能对镜像有影响，balabala。最后找了半天，还是一咬牙，用**卸载-重装新版本**的办法（一切按官方文档[Uninstall old versions + Install Docker CE](https://docs.docker.com/install/linux/docker-ce/centos/)来），结果啥事都没有，白担心了。。。
```
root@openshiftsingle dockerup $ sudo yum remove docker \
>                   docker-client \
>                   docker-client-latest \
>                   docker-common \
>                   docker-latest \
>                   docker-latest-logrotate \
>                   docker-logrotate \
>                   docker-engine

//大部分提示信息省略
Removed:
  docker.x86_64 2:1.13.1-96.gitb2f74b2.el7.centos                docker-client.x86_64 2:1.13.1-96.gitb2f74b2.el7.centos
  docker-common.x86_64 2:1.13.1-96.gitb2f74b2.el7.centos

Complete!
root@openshiftsingle dockerup $ docker version
bash: docker: command not found

----------------------------------------------------------------------------------------------------

root@openshiftsingle dockerup $ yum install -y yum-utils \
>   device-mapper-persistent-data \
>   lvm2

//大部分提示信息省略
Updated:
  lvm2.x86_64 7:2.02.180-10.el7_6.7

Dependency Updated:
  device-mapper.x86_64 7:1.02.149-10.el7_6.7                       device-mapper-event.x86_64 7:1.02.149-10.el7_6.7
  device-mapper-event-libs.x86_64 7:1.02.149-10.el7_6.7            device-mapper-libs.x86_64 7:1.02.149-10.el7_6.7
  lvm2-libs.x86_64 7:2.02.180-10.el7_6.7

Complete!

----------------------------------------------------------------------------------------------------

root@openshiftsingle dockerup $ yum-config-manager \
>     --add-repo \
>     https://download.docker.com/linux/centos/docker-ce.repo
Loaded plugins: fastestmirror
adding repo from: https://download.docker.com/linux/centos/docker-ce.repo
grabbing file https://download.docker.com/linux/centos/docker-ce.repo to /etc/yum.repos.d/docker-ce.repo
repo saved to /etc/yum.repos.d/docker-ce.repo

----------------------------------------------------------------------------------------------------

root@openshiftsingle dockerup $ yum install -y docker-ce docker-ce-cli containerd.io

//大部分提示信息省略
Installed:
  containerd.io.x86_64 0:1.2.5-3.1.el7       docker-ce.x86_64 3:18.09.6-3.el7       docker-ce-cli.x86_64 1:18.09.6-3.el7

Replaced:
  runc.x86_64 0:1.0.0-59.dev.git2abd837.el7.centos

Complete!

----------------------------------------------------------------------------------------------------

后面的建docker用户组什么的不用再做了（卸载的时候用户组没动）；但是systemctl start docker; systemctl enable docker还得执行。
```

```
呃，事实证明，问题很大。。。各种问题，最后没办法卸载了18.xx.xx版的docker（docker-ce），重新装回了docker 1.13.xx版本。
然后卸载重装openshift（注意这次卸载后再重装还得把prerequisites.yml重新执行下）。

卸载docker-ce官方给的是下面的语句：
$ sudo yum remove docker-ce
$ sudo rm -rf /var/lib/docker
但是我是执行了三个（不然后面安装openshift时候，至少docker-ce-cli还是会报冲突）：
yum remove -y docker-ce
yum remove -y docker-ce-cli
yum remove -y containerd.io
但是我没有执行rm -rf /var/lib/docker，说白了就是没清理镜像，没有发现有什么docker相关的影响。
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## docker-compose安装

- 二进制方式安装docker-compose
```
//sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
//sudo chmod +x /usr/local/bin/docker-compose

sudo curl -L https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# JDK and Maven

Spring Boot 2 (四)：使用 Docker 部署 Spring Boot http://www.ityouknow.com/springboot/2018/03/19/spring-boot-docker.html
> 安装JDK时参考了这个。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## JDK安装
```
yum -y install java-1.8.0-openjdk*

//export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64 
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64
export PATH=$PATH:$JAVA_HOME/bin 
```
```
https://github.com/ojdkbuild/contrib_jdk8u-ci/releases // 咋感觉要找个1.8版本的openjdk这么难呢？

wget https://github.com/ojdkbuild/contrib_jdk8u-ci/releases/download/jdk8u212-b04/jdk-8u212-ojdkbuild-linux-x64.zip
unzip jdk-8u212-ojdkbuild-linux-x64.zip
cp -r jdk-8u212-ojdkbuild-linux-x64/ /usr/lib/

export JAVA_HOME=/usr/lib/jdk-8u212-ojdkbuild-linux-x64  
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=${JAVA_HOME}/bin:$PATH
```

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## maven安装
```
// wget http://mirrors.shu.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz

然后解压到相应目录

export MAVEN_HOME=/usr/local/maven3
export PATH=${PATH}:${MAVEN_HOME}/bin
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Go语言环境
```
//为什么不用一个version参数控制一下，总是这样复制 --> 一来哪怕快一点点也是快；二来可以顺便记录到底用过哪些版本。

GO_DOWNLOAD_VERSION=1.9.7
wget https://dl.google.com/go/go${GO_DOWNLOAD_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_DOWNLOAD_VERSION}.linux-amd64.tar.gz

1.10.8 --> 1.10.x系列最后一个版本，主要是为了有时候试一些go module之前的情况。
wget https://dl.google.com/go/go1.10.8.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.10.8.linux-amd64.tar.gz

1.11.2
wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz

1.12.5 //为啥要去掉sudo？1.没权限话再加上sudo好了 2.这个sudo导致这一行太长，还得拖一下滚动条。要知道我本来就是想省事的~
wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz && tar -C /usr/local -xzf go1.12.5.linux-amd64.tar.gz

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

export GOBIN=$GOPATH/bin
export GO111MODULE=on

mkdir -p $GOPATH/{bin,pkg,src}

// dep
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
