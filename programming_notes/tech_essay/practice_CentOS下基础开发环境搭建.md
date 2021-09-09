
# Docker and Docker Compose

虽然安装docker方法很多，但是还是推荐用《Docker — 从入门到实践》里的办法：
- CentOS 安装 Docker CE https://yeasy.gitbooks.io/docker_practice/content/install/centos.html
- Docker Compose 项目 -- 安装与卸载 https://yeasy.gitbooks.io/docker_practice/content/compose/install.html

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## [CentOS docker安装] ( ~~https://docs.docker.com/install/linux/docker-ce/centos/~~  -->  https://docs.docker.com/engine/install/centos/)
//注：后来碰到了`Red Hat Enterprise Linux Server 7.6 (Maipo)`，安装是一模一样的。

- 卸载旧版本
```
未执行，因为是新的虚拟机
```
> 这是后来补的，因为后面不止一次碰到需要卸载的情况了（甚至是在工行Harbor项目之后也不止一次）。。。所以贴一下方便复制：
>> `yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine`
>>> 上面那句好像只对老版本docker有效，卸载新版本官方没有，应该是这个：`yum remove -y docker-ce docker-ce-cli containerd.io`

- 使用 yum 安装
```sh
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
sudo yum makecache fast
sudo yum install docker-ce

官方版：
yum install -y yum-utils
yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
yum list docker-ce --showduplicates | sort -r
yum install -y docker-ce-<VERSION_STRING> docker-ce-cli-<VERSION_STRING> containerd.io
# 比如 yum install -y docker-ce-19.03.5-3.el7 docker-ce-cli-19.03.5-3.el7 containerd.io
```
> //方便版（实际上最后一步只装docker-ce会把docker-ce-cli和containerd.io当依赖一起装了。）：
>> `yum install -y yum-utils device-mapper-persistent-data lvm2 && yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo && yum install -y docker-ce docker-ce-cli containerd.io`


- 启动 Docker CE
```
sudo systemctl enable docker
sudo systemctl start docker

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
```sh
//sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
//sudo chmod +x /usr/local/bin/docker-compose

sudo curl -L https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# JDK and Maven

Spring Boot 2 (四)：使用 Docker 部署 Spring Boot http://www.ityouknow.com/springboot/2018/03/19/spring-boot-docker.html
> 安装JDK时参考了这个。

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## JDK安装
```sh
yum -y install java-1.8.0-openjdk*

//export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.161-0.b14.el7_4.x86_64 
export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-1.8.0.191.b12-0.el7_5.x86_64
export JRE_HOME=${JAVA_HOME}/jre  
export CLASSPATH=${JAVA_HOME}/lib:${JRE_HOME}/lib  
export PATH=$PATH:$JAVA_HOME/bin 
```

```sh
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

# cmake

```sh
wget https://cmake.org/files/v3.13/cmake-3.13.0-Linux-x86_64.tar.gz
tar -xzvf cmake-3.13.0-Linux-x86_64.tar.gz
mv cmake-3.13.0-Linux-x86_64/ /opt/cmake-3.13.0/
ln -sf /opt/cmake-3.13.0/bin/*  /usr/bin/
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Go语言环境
```
//为什么不用一个version参数控制一下，总是这样复制 --> 一来哪怕快一点点也是快；二来可以顺便记录到底用过哪些版本。

GO_DOWNLOAD_VERSION=1.15.7
wget https://dl.google.com/go/go${GO_DOWNLOAD_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_DOWNLOAD_VERSION}.linux-amd64.tar.gz

GO_DOWNLOAD_VERSION=1.13.10
wget https://dl.google.com/go/go${GO_DOWNLOAD_VERSION}.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go${GO_DOWNLOAD_VERSION}.linux-amd64.tar.gz

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

export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export GOROOT=/usr/local/go
export PATH=$PATH:$GOROOT/bin

export GOBIN=$GOPATH/bin
export GO111MODULE=on

mkdir -p $GOPATH/{bin,pkg,src}

# // dep
curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

# // dlv
go get -u github.com/go-delve/delve/cmd/dlv
```

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Python语言环境

centos下搭建python双版本环境 - 宇泽的文章 - 知乎 https://zhuanlan.zhihu.com/p/88404689

Centos下python虚拟环境的安装、创建、删除、启动、退出详解 https://blog.csdn.net/zzddada/article/details/104300063

Python Virtual Environments: A Primer https://realpython.com/python-virtual-environments-a-primer/

## 实战部分

```sh
# 用pyenv安装Python3。

curl https://pyenv.run | bash
# 实质上是执行了下面这句：
# curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
``
# WARNING: seems you still have not added 'pyenv' to the load path.
# Load pyenv automatically by adding
# the following to ~/.bashrc:

export PATH="/root/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
``
#// 对于root用户，将上面三行加入.bashrc。
#// 其他用户的话，反正运行完安装pyenv的脚本也会有相应提示的，直接复制粘贴就好。


``
###////// 另外，随着 pyenv 版本演进，语句可能不一样，比如这次的提示信息是：

WARNING: seems you still have not added 'pyenv' to the load path.

# (The below instructions are intended for common
# shell setups. See the README for more guidance
# if they don't apply and/or don't work for you.)

# Add pyenv executable to PATH and
# enable shims by adding the following
# to ~/.profile:

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"

# If your ~/.profile sources ~/.bashrc,
# the lines need to be inserted before the part
# that does that. See the README for another option.

# If you have ~/.bash_profile, make sure that it
# also executes the above lines -- e.g. by
# copying them there or by sourcing ~/.profile

# Load pyenv into the shell by adding
# the following to ~/.bashrc:

eval "$(pyenv init -)"

# Make sure to restart your entire logon session
# for changes to profile files to take effect.

# Load pyenv-virtualenv automatically by adding
# the following to ~/.bashrc:

eval "$(pyenv virtualenv-init -)"

###////// 不过倒也不用特别担心，反正每次执行完前面那句，都会有提示的。
###////// 官方已经把安装脚本单独搞了一个仓库了： https://github.com/pyenv/pyenv-installer
###////// 此外这次在 ubuntu-20.04.3-desktop-amd64 上装新python版本时一堆编译问题，可见这个也没那么好用
###////// Common build problems: https://github.com/pyenv/pyenv/wiki/Common-build-problems
``


[root@marksmen1 ~]# pyenv install 3.5.0
Downloading Python-3.5.0.tar.xz...
-> https://www.python.org/ftp/python/3.5.0/Python-3.5.0.tar.xz
Installing Python-3.5.0...
Installed Python-3.5.0 to /root/.pyenv/versions/3.5.0

[root@marksmen1 ~]#
[root@marksmen1 ~]# pyenv versions
* system (set by /root/.pyenv/version)
  3.5.0
[root@marksmen1 ~]#


# 其实除了 local 以外还有一个 global 参数。更详细的可以参考realpython这篇：
# https://realpython.com/python-virtual-environments-a-primer/
# https://realpython.com/intro-to-pyenv/  -->  虽然这篇推荐切换环境时候用global，但是我碰到了如下问题：
## 系统自带python 2.7.5，先后装了3.5.0和2.7.11，然后和virtualenv一起用，并且shell断连过，所以可能乱了。
## 结果我发现后面虽然用`pyenv global system`切回了系统python（显示也确实是system），但是实际版本还是2.7.11。具体表现就是
## 输入 python -V 显示的版本不是2.7.5，而是2.7.11  -->  然后更神奇的是后来不知道怎么回事自己好了。。。
## 我猜可能跟我中间不小心混用了global和local也有关？若使用了local参数进行过设置，在当前目录会生成一个
## `.python-version`文件。这个文件对当前目录和子目录的影响力优先级更高。回头再仔细研究总结下吧。

# 所以我推荐的是只用pyenv安装python3，然后就不要再用它了。默认用系统自带的python2，需要用python3的时候用
# virtualenv创建一个虚环境就行。
[root@marksmen1 ~]#
[root@marksmen1 ~]# cat main.py
import sys
print('Using version:', sys.version[:5])
[root@marksmen1 ~]#
[root@marksmen1 ~]# python main.py
('Using version:', '2.7.5')
[root@marksmen1 ~]#
[root@marksmen1 ~]# pyenv local 3.5.0
[root@marksmen1 ~]#
[root@marksmen1 ~]# python main.py
Using version: 3.5.0
[root@marksmen1 ~]# pyenv exec python main.py
Using version: 3.5.0

--------------------------------------------------

# 源码编译安装python3（不太推荐，不知道是否会影响库路径。但是pyenv也就那样，不过还是pyenv吧）
yum install -y zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc make

wget https://www.python.org/ftp/python/3.6.4/Python-3.6.4.tar.xz
xz -d Python-3.6.4.tar.xz
tar -xvf Python-3.6.4.tar

cd Python-3.6.4
./configure prefix=/usr/local/newpython/python3
make && make install
```

```sh
# 安装pip
yum -y install epel-release
yum install -y python-pip

# 安装virtualenv
# 也可以用 yum install -y python-virtualenv 但是基本别用。不但版本低，而且还有冲突。。。
pip install --upgrade pip     # 可选，但是感觉还是升级一下吧。
pip install virtualenv
pip install virtualenvwrapper     # 可选，从后面试的情况看其实不需要了。
```

```sh
# virtualenv使用过程
mkdir -p ~/mypyenvs/env1/
virtualenv ~/mypyenvs/env1/   # virtualenv -p /usr/bin/python2.7 venv  # 可用-p参数指定Python解释器程序路径
source ~/mypyenvs/env1/bin/activate
# 老版本退出虚环境用下面这句，但新版本貌似虚环境的bin目录下就没有deactivate这个脚本，
# 不过试了下，只要输入一下 deactivate 然后回车，就自动退出该虚环境了。
source ~/mypyenvs/env1/bin/deactivate

# 虚环境的库都是在该虚环境根目录下的两个lib里，管理确实方便。
``
[root@marksmen1 env1]# pwd
/root/mypyenvs/env1
[root@marksmen1 env1]# ll
total 8
drwxr-xr-x 2 root root 4096 Nov 22 21:11 bin
drwxr-xr-x 2 root root   23 Nov 22 20:56 include
drwxr-xr-x 3 root root   23 Nov 22 20:56 lib
drwxr-xr-x 3 root root   23 Nov 22 20:56 lib64
-rw-r--r-- 1 root root  201 Nov 22 20:56 pyvenv.cfg
[root@marksmen1 env1]#
``

# 删除某个虚环境的话只要把对应目录删了就行：
rm -rf ~/mypyenvs/env1/
```

```sh
# virtualenv有个virtualenvwrapper，看网上文章说更方便些，其实用了下也就那样。
# 所以这部分可以不管了，只用virtualenv就好。
mkdir -p ~/mypyenvs2
export WORKON_HOME=~/mypyenvs2
source /usr/bin/virtualenvwrapper.sh
mkvirtualenv venv

``
[root@marksmen1 ~]# source /usr/bin/virtualenvwrapper.sh
virtualenvwrapper.user_scripts creating /root/mypyenvs2/initialize
virtualenvwrapper.user_scripts creating /root/mypyenvs2/premkvirtualenv
virtualenvwrapper.user_scripts creating /root/mypyenvs2/postmkvirtualenv
virtualenvwrapper.user_scripts creating /root/mypyenvs2/prermvirtualenv
virtualenvwrapper.user_scripts creating /root/mypyenvs2/postrmvirtualenv
virtualenvwrapper.user_scripts creating /root/mypyenvs2/predeactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/postdeactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/preactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/postactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/get_env_details
virtualenvwrapper.user_scripts creating /root/mypyenvs2/premkproject
virtualenvwrapper.user_scripts creating /root/mypyenvs2/postmkproject
[root@marksmen1 ~]#
[root@marksmen1 ~]# mkvirtualenv venv
created virtual environment CPython2.7.5.final.0-64 in 244ms
  creator CPython2Posix(dest=/root/mypyenvs2/venv, clear=False, no_vcs_ignore=False, global=False)
  seeder FromAppData(download=False, pip=bundle, wheel=bundle, setuptools=bundle, via=copy, app_data_dir=/root/.local/share/virtualenv)
    added seed packages: pip==20.2.4, setuptools==44.1.1, wheel==0.35.1
  activators PythonActivator,CShellActivator,FishActivator,PowerShellActivator,BashActivator
virtualenvwrapper.user_scripts creating /root/mypyenvs2/venv/bin/predeactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/venv/bin/postdeactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/venv/bin/preactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/venv/bin/postactivate
virtualenvwrapper.user_scripts creating /root/mypyenvs2/venv/bin/get_env_details
(venv) [root@marksmen1 ~]#
``
```

# Debian

Install Docker Engine on Debian https://docs.docker.com/engine/install/debian/

How To Install Java with Apt on Debian 9 https://www.digitalocean.com/community/tutorials/how-to-install-java-with-apt-on-debian-9
- > Installing the Default JRE/JDK
  ```sh
  sudo apt update
  sudo apt install default-jre
  ```
- > Setting the `JAVA_HOME` Environment Variable
  * > In this case the installation paths are as follows:
    ```console
    Oracle Java 10 is located at /usr/lib/jvm/java-10-oracle/jre/bin/java.
    Oracle Java 8 is located at /usr/lib/jvm/java-8-oracle/jre/bin/java.
    OpenJDK 8 is located at /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java.
    ```
  * > Then open `/etc/environment` using nano or your favorite text editor:
    ```sh
    JAVA_HOME="/usr/lib/jvm/java-8-oracle/jre"
    ```

## 个人实战部分

```sh
sudo apt update && sudo apt install -y default-jre

# Debian 9 上用apt安装完java后，系统自动搞了各种软连接，但是对比CentOS下yum安装，JAVA_HOME应该就是这个。
export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64/jre
export PATH=$PATH:$JAVA_HOME/bin
```
