
# 0.CentOS下搭建Hyperledger Fabric环境

## 环境信息
```
VirtualBox 5.2.20 r125813 (Qt5.6.2)
```
```
[test@dhcp-9-186-54-39 ~]$ cat /etc/redhat-release
CentOS Linux release 7.3.1611 (Core)
```

## 参考链接

- Hyperledger Fabric的安装和体验 https://blog.frognew.com/2018/03/hyperledger-fabric.html 
  > 注：实战时改动的地方不多，主要是这台虚拟机所需要的更改，比如有些地方权限不够加sudo之类的等等。
- CentOS 安装 Docker CE https://yeasy.gitbooks.io/docker_practice/content/install/centos.html
- Docker Compose 项目 -- 安装与卸载 https://yeasy.gitbooks.io/docker_practice/content/compose/install.html

# 1.安装Docker和docker-compose

## 1.1 安装最新版docker CE
```
sudo yum install -y yum-utils device-mapper-persistent-data lvm2   # 安装这三个工具，如果已有就更新到新版。会自动安装一些依赖。

sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo   # 这个是新加一个repo地址吧

sudo yum install docker-ce

[test@dhcp-9-186-54-39 ~]$ docker --version
Docker version 18.06.1-ce, build e68fc7a

systemctl start docker
systemctl enable docker
```

## 1.2 安装docker-compose
```
注：这句总是报权限问题，换成root了。该部分三个命令是在root用户下执行的。

curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose

chmod +x /usr/local/bin/docker-compose

[root@dhcp-9-186-54-39 bin]# docker-compose -v
docker-compose version 1.19.0, build 9e633ef
```

# 2.最小化安装Hyperledger Fabric

## 2.1 下载源码和拉取镜像
```
注：又切换回test用户了，之后也都是test用户。
注2：这台机器没有wget，所以额外多做了这步：
sudo yum -y install wget
```

### 下载源码并解压缩
```
wget https://github.com/hyperledger/fabric/archive/v1.0.6.tar.gz

tar -zxvf v1.0.6.tar.gz
```

### pull dokcer镜像
```
cd fabric-1.0.6/scripts

sudo ./bootstrap.sh
```

### 查看pull的docker镜像
```
docker images
```

## 2.2 部署Hyperledger Fabric的网络

### 下载并解压fabric-samples:
```
wget https://github.com/hyperledger/fabric-samples/archive/v1.0.6.tar.gz -O fabric-samples-v1.0.6.tar.gz

tar -zxvf fabric-samples-v1.0.6.tar.gz
```

### 接下来体验basic-network的sample:
```
cd fabric-samples-1.0.6/basic-network/

[test@dhcp-9-186-54-39 basic-network]$ docker-compose up -d
ERROR: Couldn't connect to Docker daemon at http+docker://localunixsocket - is it running?
If it's at a non-standard location, specify the URL with the DOCKER_HOST environment variable.

注：这里需要把test加到docker用户组，不然会报上面的错。反倒是那篇文章里那个错这边没报。
sudo gpasswd -a test docker
su - root
su - test

[test@dhcp-9-186-54-39 basic-network]$ docker-compose up -d
Creating couchdb ... done
Creating peer0.org1.example.com ... done
Creating orderer.example.com ...
Creating ca.example.com ...
Creating cli ...
Creating peer0.org1.example.com ...
```

### 查询当前运行的容器：
```
docker ps
```

# 3.体验fabric

执行下面的命令创建channel:
```
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel create -o orderer.example.com:7050 -c mychannel -f /etc/hyperledger/configtx/channel.tx
```

执行下面的命令将peer0.org1.example.com加入到通道中：
```
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@org1.example.com/msp" peer0.org1.example.com peer channel join -b mychannel.block
```

为peer节点peer0.org1.example.com安装chaincode：
```
docker exec -it cli sh   # 这一步完成后进入docker环境执行。

peer chaincode install -n mychaincode -v v0 -p github.com/chaincode_example02
```

实例化chaincode：
```
peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n mychaincode -v v0 -c '{"Args": ["init", "foo", "100", "bar", "50"]}'
```

模拟一次transaction：
```
peer chaincode query -C mychannel -n mychaincode -v v0 -c '{"Args": ["query", "foo"]}'
Query Result: 100

peer chaincode query -C mychannel -n mychaincode -v v0 -c '{"Args": ["query", "bar"]}'
Query Result: 50

peer chaincode invoke -C mychannel -n mychaincode -v v0 -c '{"Args": ["invoke", "foo", "bar", "10"]}'

peer chaincode query -C mychannel -n mychaincode -v v0 -c '{"Args": ["query", "foo"]}'
Query Result: 90

peer chaincode query -C mychannel -n mychaincode -v v0 -c '{"Args": ["query", "bar"]}'
Query Result: 60
```
