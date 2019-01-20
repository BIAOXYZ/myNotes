
# 环境信息


# 搭建过程（仍未完成，但是不一定继续了。一是因为感觉就是过去版本或者环境的原因，二是因为别的机器上也搭好了，这个必要性也没多大了）

其他连接：
>  Hyperledger Fabric 1.0 从零开始（二）——环境构建（公网） https://www.cnblogs.com/aberic/p/7531202.html 【0】

> Hyperledger Fabric 1.0 从零开始（四）——Fabric源码及镜像文件处理 https://www.cnblogs.com/aberic/p/7532114.html 【0-1】

> 搭建和运行hyperledger fabric1.0alpha版本过程分析 - CSDN博客 https://blog.csdn.net/kojhliang/article/details/66971404

> https://cn.aliyun.com/jiaocheng/125437.html

怎么通过源码编译的方式，来编译 hyperledger fabric 1.0.0 alpha版本? - roamer的回答 - 知乎
https://www.zhihu.com/question/59547541/answer/166348295


- 安装curl
```
这两个中的一个吧，不过这个问题不大：

sudo apt install curl
sudo apt-get install curl
```
> 有些攻略里提到要安装nodejs，虽然过程中也安装了，但是感觉好像不是必须的。安装也是很简单，一条命令搞定。


- 安装go
  - 区块链之Hyperledger（超级账本）Fabric v1.0 的环境搭建（超详细教程）https://blog.csdn.net/so5418418/article/details/78355868 【1】
  - Ubuntu16.04搭建Hyperledger Fabric 1.0.5开发环境 https://blog.csdn.net/diligent_lee/article/details/79141450 【2】

```
自带的或者apt install直接安装的Go版本太旧，必须装1.9以上的。
主要方法包括Go环境变量设置都是【1】的，但是版本用的是1.9.2的，所以安装语句用的是【2】的：
wget https://dl.google.com/go/go1.9.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.9.2.linux-amd64.tar.gz
```

- 安装docker
  - Hyperledger Fabric 1.0 安装和使用 https://blog.csdn.net/yeasy/article/details/54928343 【3】
  - https://docs.docker.com/install/linux/docker-ce/ubuntu/ 【4】
```
直接apt-get install的docker版本太旧，所以还得先卸载再装，卸载的命令依稀记得是【4】里来的，再多加一个docker-ce：
sudo apt-get remove docker docker-engine docker-ce docker.io

然后好像用【3】里的安装docker的命令就能安上17以上的版本了：
curl -fsSL https://get.docker.com/ | sh

安完接着执行里里面这步，不知道用处是啥：
【注：后来这句直接注释掉了，所以没起作用我觉得。】

以 Ubuntu 14.04 为例，安装成功后，修改 Docker 服务配置（/etc/default/docker 文件）
DOCKER_OPTS="$DOCKER_OPTS -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --api-cors-header='*'"
```

- 安装docker-composer
  - ubuntu16.04下更新pip https://blog.csdn.net/wxyangid/article/details/53560851 【5】
```
又是直接apt-get的pip版本太旧，靠。。。涉及更新pip，好多类似 "sudo -H pip install --upgrade pip" 都不行。
最后用的是【5】里的这个，才把pip从8.1.1升级9.0.3：
sudo python -m pip install --upgrade pip

然后安装docker-compose用的是【3】里的语句，因为看起来这个语句相比【1】明显保证了版本大于1.8.0，比较靠谱：
sudo pip install docker-compose>=1.8.0
但是上面那个语句会报错：
"The directory '/home/ts/.cache/pip/http' or its parent directory is not owned by the current user and the cache has been disabled. 
Please check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag.
The directory '/home/ts/.cache/pip' or its parent directory is not owned by the current user and caching wheels has been disabled. 
check the permissions and owner of that directory. If executing pip with sudo, you may want sudo's -H flag."
于是按报错提示加了-H就好了：
sudo -H pip install docker-compose>=1.8.0
```

- 下载Fabric代码
```
按【1】依次执行：
mkdir –p ~/go/src/github.com/hyperledger 
cd ~/go/src/github.com/hyperledger
git clone https://github.com/hyperledger/fabric.git
```

- 下载Fabric镜像
```
按【1】依次执行：
cd ~/go/src/github.com/hyperledger/fabric/examples/e2e_cli/
source download-dockerimages.sh -c x86_64-1.0.0 -f x86_64-1.0.0

然后报下面这个错。。。
"Warning: failed to get default registry endpoint from daemon (Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.37/info: dial unix /var/run/docker.sock: connect: permission denied). Using system default: https://index.docker.io/v1/
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.37/images/create?fromImage=hyperledger%2Ffabric-peer&tag=x86_64-1.0.0: dial unix /var/run/docker.sock: connect: permission denied
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Post http://%2Fvar%2Frun%2Fdocker.sock/v1.37/images/hyperledger/fabric-peer:x86_64-1.0.0/tag?repo=hyperledger%2Ffabric-peer&tag=latest: dial unix /var/run/docker.sock: connect: permission denied
==> FABRIC IMAGE: orderer"

感觉上面那种拖镜像的办法不行。所以最终决定按【0-1】第2.2部分的方法执行。
和原帖子不同的是，之所以加sudo在前面是因为没sudo不能正确执行。
原因参见该帖（免sudo使用docker命令 https://blog.csdn.net/baidu_36342103/article/details/69357438 【6】）
PS:没sudo的话查个docker version都报错的。。。
--------------------------------------------------
ts@ts-Satellite-M500:~$ docker version
Client:
 Version:       18.03.0-ce
 API version:   1.37
 Go version:    go1.9.4
 Git commit:    0520e24
 Built: Wed Mar 21 23:10:01 2018
 OS/Arch:       linux/amd64
 Experimental:  false
 Orchestrator:  swarm
Got permission denied while trying to connect to the Docker daemon socket at unix:///var/run/docker.sock: Get http://%2Fvar%2Frun%2Fdocker.sock/v1.37/version: dial unix /var/run/docker.sock: connect: permission denied
ts@ts-Satellite-M500:~$ sudo docker version
[sudo] password for ts:
Client:
 Version:       18.03.0-ce
 API version:   1.37
 Go version:    go1.9.4
 Git commit:    0520e24
 Built: Wed Mar 21 23:10:01 2018
 OS/Arch:       linux/amd64
 Experimental:  false
 Orchestrator:  swarm

Server:
 Engine:
  Version:      18.03.0-ce
  API version:  1.37 (minimum version 1.12)
  Go version:   go1.9.4
  Git commit:   0520e24
  Built:        Wed Mar 21 23:08:31 2018
  OS/Arch:      linux/amd64
  Experimental: false
--------------------------------------------------


sudo docker pull hyperledger/fabric-tools:x86_64-1.0.0
sudo docker pull hyperledger/fabric-orderer:x86_64-1.0.0
sudo docker pull hyperledger/fabric-peer:x86_64-1.0.0
sudo docker pull hyperledger/fabric-couchdb:x86_64-1.0.0
sudo docker pull hyperledger/fabric-kafka:x86_64-1.0.0
sudo docker pull hyperledger/fabric-ca:x86_64-1.0.0
sudo docker pull hyperledger/fabric-ccenv:x86_64-1.0.0
sudo docker pull hyperledger/fabric-baseimage:x86_64-1.0.0

但是最后一步有问题：
ts@ts-Satellite-M500:~$ sudo docker pull hyperledger/fabric-baseimage:x86_64-1.0.0
Error response from daemon: manifest for hyperledger/fabric-baseimage:x86_64-1.0.0 not found

试了试latest或者x86_64-1.0.5也不行，无语凝噎：
ts@ts-Satellite-M500:~$ sudo docker pull hyperledger/fabric-baseimage:latest
Error response from daemon: manifest for hyperledger/fabric-baseimage:latest not found
ts@ts-Satellite-M500:~$ sudo docker pull hyperledger/fabric-baseimage:x86_64-1.0.5
Error response from daemon: manifest for hyperledger/fabric-baseimage:x86_64-1.0.5 not found

只好用那个报错信息在bing里搜素，搜到下面两个帖子。都说是指定的tag不存在：
（第一个帖子的回复里有人提到下面那个链接可以查到最新的tag竟然是x86_64-0.4.7，用这个tag成功了）：
1) Can't be pull images named hyperledger/fabric-* #3012   https://github.com/docker/kitematic/issues/3012
  - https://hub.docker.com/r/hyperledger/fabric-baseimage/tags/
2) Hyperledger Fabric v1.0.5 区块链入门   http://www.netkiller.cn/journal/hyperledger.html
stackoverflow上也有一个类似的方法，不过是镜像都拖成功后才发现- -
https://stackoverflow.com/questions/43830372/error-manifest-for-hyperledger-fabric-ordererlatest-not-found

ts@ts-Satellite-M500:~$ sudo docker pull hyperledger/fabric-baseimage:x86_64-0.4.7
x86_64-0.4.7: Pulling from hyperledger/fabric-baseimage
22dc81ace0ea: Pull complete 
1a8b3c87dba3: Pull complete 
91390a1c435a: Pull complete 
07844b14977e: Pull complete 
b78396653dae: Pull complete 
e9ccdcaffc14: Pull complete 
bc4f37a4add9: Pull complete 
ce2848c93b89: Pull complete 
e17f2e966cf9: Pull complete 
a8ff8b38536a: Pull complete 
34f13289ca59: Pull complete 
Digest: sha256:7cb40f31cdf8b68e9ee9f17fdad8b05c4ffcd3da87ddc4a0980981534b4d763c
Status: Downloaded newer image for hyperledger/fabric-baseimage:x86_64-0.4.7

ts@ts-Satellite-M500:~$ sudo docker images
REPOSITORY                     TAG                 IMAGE ID            CREATED             SIZE
hyperledger/fabric-baseimage   x86_64-0.4.7        390ac2e95bc7        9 days ago          1.41GB
hyperledger/fabric-tools       x86_64-1.0.0        0403fd1c72c7        8 months ago        1.32GB
hyperledger/fabric-couchdb     x86_64-1.0.0        2fbdbf3ab945        8 months ago        1.48GB
hyperledger/fabric-kafka       x86_64-1.0.0        dbd3f94de4b5        8 months ago        1.3GB
hyperledger/fabric-orderer     x86_64-1.0.0        e317ca5638ba        8 months ago        179MB
hyperledger/fabric-peer        x86_64-1.0.0        6830dcd7b9b5        8 months ago        182MB
hyperledger/fabric-ccenv       x86_64-1.0.0        7182c260a5ca        8 months ago        1.29GB
hyperledger/fabric-ca          x86_64-1.0.0        a15c59ecda5b        8 months ago        238MB

还是按照【1】的办法，启动用例：
ts@ts-Satellite-M500:~/go/src/github.com/hyperledger/fabric/examples/e2e_cli$ ./network_setup.sh up
setting to default channel 'mychannel'
mychannel

Building cryptogen
make: Entering directory '/home/ts/go/src/github.com/hyperledger/fabric'
Building release/linux-amd64/bin/configtxgen for linux-amd64
mkdir -p release/linux-amd64/bin
CGO_CFLAGS=" " GOOS=linux GOARCH=amd64 go build -o /home/ts/go/src/github.com/hyperledger/fabric/release/linux-amd64/bin/configtxgen -tags "experimental nopkcs11" -ldflags "-X github.com/hyperledger/fabric/common/tools/configtxgen/metadata.Version=1.1.1-snapshot-851d766" github.com/hyperledger/fabric/common/tools/configtxgen
Building release/linux-amd64/bin/cryptogen for linux-amd64
mkdir -p release/linux-amd64/bin
CGO_CFLAGS=" " GOOS=linux GOARCH=amd64 go build -o /home/ts/go/src/github.com/hyperledger/fabric/release/linux-amd64/bin/cryptogen -tags "experimental nopkcs11" -ldflags "-X github.com/hyperledger/fabric/common/tools/cryptogen/metadata.Version=1.1.1-snapshot-851d766" github.com/hyperledger/fabric/common/tools/cryptogen
Building release/linux-amd64/bin/configtxlator for linux-amd64
mkdir -p release/linux-amd64/bin
CGO_CFLAGS=" " GOOS=linux GOARCH=amd64 go build -o /home/ts/go/src/github.com/hyperledger/fabric/release/linux-amd64/bin/configtxlator -tags "experimental nopkcs11" -ldflags "-X github.com/hyperledger/fabric/common/tools/configtxlator/metadata.Version=1.1.1-snapshot-851d766" github.com/hyperledger/fabric/common/tools/configtxlator
Building release/linux-amd64/bin/peer for linux-amd64
mkdir -p release/linux-amd64/bin
CGO_CFLAGS=" " GOOS=linux GOARCH=amd64 go build -o /home/ts/go/src/github.com/hyperledger/fabric/release/linux-amd64/bin/peer -tags "experimental nopkcs11" -ldflags "-X github.com/hyperledger/fabric/common/metadata.Version=1.1.1-snapshot-851d766 -X github.com/hyperledger/fabric/common/metadata.BaseVersion=0.4.6 -X github.com/hyperledger/fabric/common/metadata.BaseDockerLabel=org.hyperledger.fabric -X github.com/hyperledger/fabric/common/metadata.DockerNamespace=hyperledger -X github.com/hyperledger/fabric/common/metadata.BaseDockerNamespace=hyperledger -X github.com/hyperledger/fabric/common/metadata.Experimental=true" github.com/hyperledger/fabric/peer
Building release/linux-amd64/bin/orderer for linux-amd64
mkdir -p release/linux-amd64/bin
CGO_CFLAGS=" " GOOS=linux GOARCH=amd64 go build -o /home/ts/go/src/github.com/hyperledger/fabric/release/linux-amd64/bin/orderer -tags "experimental nopkcs11" -ldflags "-X github.com/hyperledger/fabric/common/metadata.Version=1.1.1-snapshot-851d766 -X github.com/hyperledger/fabric/common/metadata.BaseVersion=0.4.6 -X github.com/hyperledger/fabric/common/metadata.BaseDockerLabel=org.hyperledger.fabric -X github.com/hyperledger/fabric/common/metadata.DockerNamespace=hyperledger -X github.com/hyperledger/fabric/common/metadata.BaseDockerNamespace=hyperledger -X github.com/hyperledger/fabric/common/metadata.Experimental=true" github.com/hyperledger/fabric/orderer
mkdir -p release/linux-amd64/bin
make: Leaving directory '/home/ts/go/src/github.com/hyperledger/fabric'

##########################################################
##### Generate certificates using cryptogen tool #########
##########################################################
org1.example.com
org2.example.com

Using configtxgen -> /home/ts/go/src/github.com/hyperledger/fabric/examples/e2e_cli/../../release/linux-amd64/bin/configtxgen
##########################################################
#########  Generating Orderer Genesis block ##############
##########################################################
2018-04-06 01:33:02.578 CST [common/tools/configtxgen] main -> INFO 001 Loading configuration
2018-04-06 01:33:02.616 CST [msp] getMspConfig -> INFO 002 Loading NodeOUs
2018-04-06 01:33:02.616 CST [msp] getMspConfig -> INFO 003 Loading NodeOUs
2018-04-06 01:33:02.617 CST [common/tools/configtxgen] doOutputBlock -> INFO 004 Generating genesis block
2018-04-06 01:33:02.617 CST [common/tools/configtxgen] doOutputBlock -> INFO 005 Writing genesis block

#################################################################
### Generating channel configuration transaction 'channel.tx' ###
#################################################################
2018-04-06 01:33:02.651 CST [common/tools/configtxgen] main -> INFO 001 Loading configuration
2018-04-06 01:33:02.669 CST [common/tools/configtxgen] doOutputChannelCreateTx -> INFO 002 Generating new channel configtx
2018-04-06 01:33:02.670 CST [msp] getMspConfig -> INFO 003 Loading NodeOUs
2018-04-06 01:33:02.670 CST [msp] getMspConfig -> INFO 004 Loading NodeOUs
2018-04-06 01:33:02.722 CST [common/tools/configtxgen] doOutputChannelCreateTx -> INFO 005 Writing new channel tx

#################################################################
#######    Generating anchor peer update for Org1MSP   ##########
#################################################################
2018-04-06 01:33:02.748 CST [common/tools/configtxgen] main -> INFO 001 Loading configuration
2018-04-06 01:33:02.769 CST [common/tools/configtxgen] doOutputAnchorPeersUpdate -> INFO 002 Generating anchor peer update
2018-04-06 01:33:02.770 CST [common/tools/configtxgen] doOutputAnchorPeersUpdate -> INFO 003 Writing anchor peer update

#################################################################
#######    Generating anchor peer update for Org2MSP   ##########
#################################################################
2018-04-06 01:33:02.799 CST [common/tools/configtxgen] main -> INFO 001 Loading configuration
2018-04-06 01:33:02.826 CST [common/tools/configtxgen] doOutputAnchorPeersUpdate -> INFO 002 Generating anchor peer update
2018-04-06 01:33:02.827 CST [common/tools/configtxgen] doOutputAnchorPeersUpdate -> INFO 003 Writing anchor peer update

ERROR: Couldn't connect to Docker daemon at http+docker://localhost - is it running?

If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.
ERROR !!!! Unable to pull the images 
ts@ts-Satellite-M500:~/go/src/github.com/hyperledger/fabric/examples/e2e_cli$ 


后面变成了这个错，不知道为什么。猜测是脚本里拉docker标签默认拉latest，但是本机都不是latest
ts@ts-Satellite-M500:~/go/src/github.com/hyperledger/fabric/examples/e2e_cli$ ./network_setup.sh up
setting to default channel 'mychannel'
crypto-config directory already exists.
Pulling peer0.org2.example.com (hyperledger/fabric-peer:latest)...
ERROR: manifest for hyperledger/fabric-peer:latest not found
ERROR !!!! Unable to pull the images 
```


# 这是当时为了解决“Couldn't connect to Docker daemon”那个报错查询了下记下来的链接，也没有实践，权且一起记下来吧。可能有用。

ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running? #4181
https://github.com/docker/compose/issues/4181

Couldn't connect to Docker daemon at http+unix://var/run/docker.sock - is it running? #1214
https://github.com/docker/compose/issues/1214


[test@dhcp-9-186-54-39 basic-network]$ docker-compose up -d
ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running?
If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.

解决 ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running? https://blog.csdn.net/xiojing825/article/details/79494408

