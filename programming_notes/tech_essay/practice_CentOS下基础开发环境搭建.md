
# Docker and Docker Compose

虽然安装docker方法很多，但是还是推荐用《Docker — 从入门到实践》里的办法：
- CentOS 安装 Docker CE https://yeasy.gitbooks.io/docker_practice/content/install/centos.html
- Docker Compose 项目 -- 安装与卸载 https://yeasy.gitbooks.io/docker_practice/content/compose/install.html

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
2019.02.26更新：看来并非任何机器和系统都如此，刚才就碰到了需要启动docker服务的情况:
(注意刚安装完不启动的话执行docker version时候那句报错。)

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

## docker-compose安装

- 二进制方式安装docker-compose
```
//sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
//sudo chmod +x /usr/local/bin/docker-compose

sudo curl -L https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

# JDK and Maven

Spring Boot 2 (四)：使用 Docker 部署 Spring Boot http://www.ityouknow.com/springboot/2018/03/19/spring-boot-docker.html
> 安装JDK时参考了这个。

## JDK安装
```
yum -y install java-1.8.0-openjdk*

//export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64 
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64
export PATH=$PATH:$JAVA_HOME/bin 
```

## maven安装
```
// wget http://mirrors.shu.edu.cn/apache/maven/maven-3/3.5.2/binaries/apache-maven-3.5.2-bin.tar.gz
wget http://mirrors.hust.edu.cn/apache/maven/maven-3/3.5.4/binaries/apache-maven-3.5.4-bin.tar.gz

然后解压到相应目录

export MAVEN_HOME=/usr/local/maven3
export PATH=${PATH}:${MAVEN_HOME}/bin
```

# Go语言环境
```
wget https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.11.2.linux-amd64.tar.gz

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin
```
