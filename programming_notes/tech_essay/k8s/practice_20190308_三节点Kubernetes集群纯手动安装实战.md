

# 20190308_三节点Kubernetes集群纯手动安装实战

----------------------------------------------------------------------------------------------------
# `#` 零、准备阶段
----------------------------------------------------------------------------------------------------

## 环境信息

```
三台一模一样，故只以第一台为例：

[root@cloudsec2 ~]# cat /etc/redhat-release
CentOS Linux release 7.6.1810 (Core)


[root@cloudsec2 ~]# cat /proc/cpuinfo| grep "physical id"| sort| uniq| wc -l
1
[root@cloudsec2 ~]# cat /proc/cpuinfo| grep "cpu cores"| uniq
cpu cores       : 4
[root@cloudsec2 ~]# cat /proc/cpuinfo| grep "processor"| wc -l
4
[root@cloudsec2 ~]# cat /proc/cpuinfo | grep name | cut -f2 -d: | uniq -c
      4  Intel(R) Xeon(R) CPU E5-2683 v3 @ 2.00GHz


[root@cloudsec2 ~]# free -m
              total        used        free      shared  buff/cache   available
Mem:          15879         695        9722         834        5461       13985
Swap:          2047           0        2047


[root@cloudsec2 ~]# lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
xvda    202:0    0  100G  0 disk
├─xvda1 202:1    0  256M  0 part /boot
└─xvda2 202:2    0 99.8G  0 part /
xvdb    202:16   0    2G  0 disk
└─xvdb1 202:17   0    2G  0 part [SWAP]


[root@cloudsec2 ~]# hostname
cloudsec2.sl.cloud9.ibm.com
```

| 主机名 | ip地址 | 角色 |
|--|--|:--:|
|cloudsec2.sl.cloud9.ibm.com | 9.186.102.196 | master | 
|cloudsec3.sl.cloud9.ibm.com | 9.186.102.71 | node1 | 
|cloudsec4.sl.cloud9.ibm.com | 9.186.102.73 | node2 | 

```
在每台机器上执行下`ip a`均会发现`9`开头的`eth0:0`是个虚拟IP，`10`开头的那个才是`eth0`。但是实际上用`10`开头的那套IP反而不行。
但是两套IP都是能ping通的，所以导致我前前后后搞了好几遍才确定需要用9开头的那套IP，因此过程中的命令显示结果里有些时间可能是混杂的。

[root@cloudsec4 ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 06:6f:01:7b:f6:d9 brd ff:ff:ff:ff:ff:ff
    inet 10.174.93.73/24 brd 10.174.93.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet 9.186.102.73/24 brd 9.186.102.255 scope global eth0:0
       valid_lft forever preferred_lft forever
    inet6 fe80::46f:1ff:fe7b:f6d9/64 scope link
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:45:57:82:b6 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
```

## 搭建过程的大体步骤和思路

因为是不借助诸如kubeadm之类的工具，所以过程很长。大致可以分解为如下几个子步骤：
- 在三个节点上搭建ETCD集群
- 在master节点上安装kube-apiserver、kube-controller-manager、kube-scheduler
- 分别在两个node节点上安装kubelet和kube_proxy（用的容器方式，所以这两个节点要安装docker）
- 分别在两个node节点上安装flannel

## 参考链接

kubernetes1.13.1+etcd3.3.10+flanneld0.10集群部署 https://www.kubernetes.org.cn/5025.html
>> notes: 找了很多攻略后，决定基本按照这个来，只是把小坑补一下就好。所以后面标题里会有不少标题直接用原文里的（这种标题有双引号），最主要的目的就是好和原文对比。。。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

----------------------------------------------------------------------------------------------------
# `#` 一、安装过程
----------------------------------------------------------------------------------------------------

## 没看攻略之前各个节点都安装了下docker，实际上按攻略只需在两个node上装docker即可 //注意这里开始想用k8suser1(k8suser2、k8suser3)之类的普通用户。后来又想了想，还是先用root安一遍好了。。。

```
yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
//yum makecache fast  这一步没执行，也没啥影响
yum install -y docker-ce
```

>> 此外，由于三个节点都是用root安装，故全都先新建了`/root/rootpackages/`目录用来存放需要的二进制文件的tar包。

:couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple::couple:

# "四、Master部署" --> master节点ETCD安装

## "4.1 下载软件"

```
两个问题：
1.master节点肯定没用到kubernetes-client-linux-amd64.tar.gz。我最后还Ctrl+F搜了下，这个包确实没用到：
  master用的是kubernetes-server-linux-amd64.tar.gz；两个普通node用的是kubernetes-node-linux-amd64.tar.gz。
  实际上我看了下，解压后都是一些二进制文件，并且node包里有的server包里都有。
2.master节点似乎也没有用到flannel，因为最后装flannel的时候，看攻略里前面命令行的hostname是elasticsearch02，
  那么对称的elasticsearch03当然也要装。但是作为master的elasticsearch01并没有提到，我认为master上docker都不装了，
  那就是根本没想让master承担工作负载，所以当然不需要装为了解决跨pod容器通讯的flannel。

wget https://dl.k8s.io/v1.13.1/kubernetes-server-linux-amd64.tar.gz
//wget https://dl.k8s.io/v1.13.1/kubernetes-client-linux-amd64.tar.gz
wget https://github.com/etcd-io/etcd/releases/download/v3.3.10/etcd-v3.3.10-linux-amd64.tar.gz
//wget https://github.com/coreos/flannel/releases/download/v0.10.0/flannel-v0.10.0-linux-amd64.tar.gz
```

## "4.2 cfssl安装"

```
wget https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
wget https://pkg.cfssl.org/R1.2/cfssl-certinfo_linux-amd64
chmod +x cfssl_linux-amd64 cfssljson_linux-amd64 cfssl-certinfo_linux-amd64
mv cfssl_linux-amd64 /usr/local/bin/cfssl
mv cfssljson_linux-amd64 /usr/local/bin/cfssljson
mv cfssl-certinfo_linux-amd64 /usr/bin/cfssl-certinfo
```

## "4.3 创建etcd证书"

```
mkdir /k8s/etcd/{bin,cfg,ssl} -p
mkdir /k8s/kubernetes/{bin,cfg,ssl} -p

[root@cloudsec2 k8s]# tree
.
├── etcd
│   ├── bin
│   ├── cfg
│   └── ssl
└── kubernetes
    ├── bin
    ├── cfg
    └── ssl

8 directories, 0 files

cd /k8s/etcd/ssl/
```

### "1）etcd ca配置"

```
cat << EOF | tee ca-config.json
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "etcd": {
         "expiry": "87600h",
         "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ]
      }
    }
  }
}
EOF
```

### "2）etcd ca证书"

```
cat << EOF | tee ca-csr.json
{
    "CN": "etcd CA",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing"
        }
    ]
}
EOF
```

### "3）etcd server证书"

>> //注：这个需要改下hosts里的三个ip，开始没看到，跳坑了。
```
cat << EOF | tee server-csr.json
{
    "CN": "etcd",
    "hosts": [
    "9.186.102.196",
    "9.186.102.71",
    "9.186.102.73"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing"
        }
    ]
}
EOF
```

```
[root@cloudsec2 ssl]# ll
total 12
-rw-r--r--. 1 root root 288 Feb 28 03:04 ca-config.json
-rw-r--r--. 1 root root 209 Feb 28 03:06 ca-csr.json
-rw-r--r--. 1 root root 278 Feb 28 03:06 server-csr.json
```

### "4）生成etcd ca证书和私钥 初始化ca" and "生成server证书"

```
//这里就是因为上面server-csr.json里IP的问题掉坑了，看下两个ll显示的文件修改时间就知道了。。。

cfssl gencert -initca ca-csr.json | cfssljson -bare ca
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=etcd server-csr.json | cfssljson -bare server

[root@cloudsec2 ssl]# ll
total 12
-rw-r--r--. 1 root root 288 Feb 28 05:03 ca-config.json
-rw-r--r--. 1 root root 209 Feb 28 05:03 ca-csr.json
-rw-r--r--. 1 root root 288 Feb 28 05:03 server-csr.json
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]# cfssl gencert -initca ca-csr.json | cfssljson -bare ca
2019/02/28 05:04:08 [INFO] generating a new CA key and certificate from CSR
2019/02/28 05:04:08 [INFO] generate received request
2019/02/28 05:04:08 [INFO] received CSR
2019/02/28 05:04:08 [INFO] generating key: rsa-2048
2019/02/28 05:04:08 [INFO] encoded CSR
2019/02/28 05:04:08 [INFO] signed certificate with serial number 336774999684520291143923745696251571775037995197
[root@cloudsec2 ssl]# ll
total 24
-rw-r--r--. 1 root root  288 Feb 28 05:03 ca-config.json
-rw-r--r--. 1 root root  956 Feb 28 05:04 ca.csr
-rw-r--r--. 1 root root  209 Feb 28 05:03 ca-csr.json
-rw-------. 1 root root 1679 Feb 28 05:04 ca-key.pem
-rw-r--r--. 1 root root 1265 Feb 28 05:04 ca.pem
-rw-r--r--. 1 root root  288 Feb 28 05:03 server-csr.json
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]# cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=etcd server-csr.json | cfssljson -bare server
2019/02/28 05:04:34 [INFO] generate received request
2019/02/28 05:04:34 [INFO] received CSR
2019/02/28 05:04:34 [INFO] generating key: rsa-2048
2019/02/28 05:04:34 [INFO] encoded CSR
2019/02/28 05:04:34 [INFO] signed certificate with serial number 455463720617718630537459898742172295350320990283
2019/02/28 05:04:34 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
[root@cloudsec2 ssl]# ll
total 36
-rw-r--r--. 1 root root  288 Feb 28 05:03 ca-config.json
-rw-r--r--. 1 root root  956 Feb 28 05:04 ca.csr
-rw-r--r--. 1 root root  209 Feb 28 05:03 ca-csr.json
-rw-------. 1 root root 1679 Feb 28 05:04 ca-key.pem
-rw-r--r--. 1 root root 1265 Feb 28 05:04 ca.pem
-rw-r--r--. 1 root root 1013 Feb 28 05:04 server.csr
-rw-r--r--. 1 root root  288 Feb 28 05:03 server-csr.json
-rw-------. 1 root root 1675 Feb 28 05:04 server-key.pem
-rw-r--r--. 1 root root 1338 Feb 28 05:04 server.pem
```

## "4.4 etcd安装"

### "1）解压缩"

```
//攻略里没提的trivial步骤，总得先进到etcd安装包在的目录吧
cd /root/rootpackages/

tar -xvf etcd-v3.3.10-linux-amd64.tar.gz
cd etcd-v3.3.10-linux-amd64/
cp etcd etcdctl /k8s/etcd/bin/
```

### "2）配置etcd主文件"

> vi /k8s/etcd/cfg/etcd.conf
>> //这个需要修改的有5行
```
#[Member]
ETCD_NAME="etcd01"
ETCD_DATA_DIR="/data1/etcd"
###ETCD_LISTEN_PEER_URLS="https://10.2.8.44:2380"
###ETCD_LISTEN_CLIENT_URLS="https://10.2.8.44:2379"
ETCD_LISTEN_PEER_URLS="https://9.186.102.196:2380"
ETCD_LISTEN_CLIENT_URLS="https://9.186.102.196:2379"
 
#[Clustering]
###ETCD_INITIAL_ADVERTISE_PEER_URLS="https://10.2.8.44:2380"
###ETCD_ADVERTISE_CLIENT_URLS="https://10.2.8.44:2379"
###ETCD_INITIAL_CLUSTER="etcd01=https://10.2.8.44:2380,etcd02=https://10.2.8.65:2380,etcd03=https://10.2.8.34:2380"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://9.186.102.196:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://9.186.102.196:2379"
ETCD_INITIAL_CLUSTER="etcd01=https://9.186.102.196:2380,etcd02=https://9.186.102.71:2380,etcd03=https://9.186.102.73:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"

#[Security]
ETCD_CERT_FILE="/k8s/etcd/ssl/server.pem"
ETCD_KEY_FILE="/k8s/etcd/ssl/server-key.pem"
ETCD_TRUSTED_CA_FILE="/k8s/etcd/ssl/ca.pem"
ETCD_CLIENT_CERT_AUTH="true"
ETCD_PEER_CERT_FILE="/k8s/etcd/ssl/server.pem"
ETCD_PEER_KEY_FILE="/k8s/etcd/ssl/server-key.pem"
ETCD_PEER_TRUSTED_CA_FILE="/k8s/etcd/ssl/ca.pem"
ETCD_PEER_CLIENT_CERT_AUTH="true"
```

### "3）配置etcd启动文件"

```
[root@cloudsec2 cfg]# mkdir /data1/etcd
mkdir: cannot create directory ‘/data1/etcd’: No such file or directory

//原版应该是少了个-p，不然之前根本没提过去创建/data1这个目录啊。这个/data1/etcd/是准备做ETCD的数据目录。

mkdir -p /data1/etcd
vi /usr/lib/systemd/system/etcd.service
```

```
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
WorkingDirectory=/data1/etcd/
EnvironmentFile=-/k8s/etcd/cfg/etcd.conf
# set GOMAXPROCS to number of processors
ExecStart=/bin/bash -c "GOMAXPROCS=$(nproc) /k8s/etcd/bin/etcd --name=\"${ETCD_NAME}\" --data-dir=\"${ETCD_DATA_DIR}\" --listen-client-urls=\"${ETCD_LISTEN_CLIENT_URLS}\" --listen-peer-urls=\"${ETCD_LISTEN_PEER_URLS}\" --advertise-client-urls=\"${ETCD_ADVERTISE_CLIENT_URLS}\" --initial-cluster-token=\"${ETCD_INITIAL_CLUSTER_TOKEN}\" --initial-cluster=\"${ETCD_INITIAL_CLUSTER}\" --initial-cluster-state=\"${ETCD_INITIAL_CLUSTER_STATE}\" --cert-file=\"${ETCD_CERT_FILE}\" --key-file=\"${ETCD_KEY_FILE}\" --trusted-ca-file=\"${ETCD_TRUSTED_CA_FILE}\" --client-cert-auth=\"${ETCD_CLIENT_CERT_AUTH}\" --peer-cert-file=\"${ETCD_PEER_CERT_FILE}\" --peer-key-file=\"${ETCD_PEER_KEY_FILE}\" --peer-trusted-ca-file=\"${ETCD_PEER_TRUSTED_CA_FILE}\" --peer-client-cert-auth=\"${ETCD_PEER_CLIENT_CERT_AUTH}\""
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

### "4）启动 注意启动前etcd02、etcd03同样配置下"

>> //这个“同样配置下”坑死了，证书啥的应该是复制过去就得了，不能重新生成。
```
systemctl daemon-reload
systemctl enable etcd
systemctl start etcd

//这个失败的原因好像是两个node节点中的某一个的etcd服务没启动

[root@cloudsec2 cfg]# systemctl daemon-reload
[root@cloudsec2 cfg]# systemctl enable etcd
Created symlink from /etc/systemd/system/multi-user.target.wants/etcd.service to /usr/lib/systemd/system/etcd.service.
[root@cloudsec2 cfg]# systemctl start etcd
Job for etcd.service failed because a timeout was exceeded. See "systemctl status etcd.service" and "journalctl -xe" for details.
```

--------------------------------------------------分隔线：开始--------------------------------------------------

# 配置node1和node2的ETCD or 两个普通节点的ETCD安装

## 在两个节点下载好ETCD的二进制文件并建好需要的目录

```
//两个node均需执行。

wget https://github.com/etcd-io/etcd/releases/download/v3.3.10/etcd-v3.3.10-linux-amd64.tar.gz

mkdir /k8s/etcd/{bin,cfg,ssl} -p
mkdir /k8s/kubernetes/{bin,cfg,ssl} -p
```

## 从master把证书远程复制到其他两个节点

```
//这句在master上执行。证书什么的不能再次生成。
//实际上不需要全部复制过去，但是懒得详细区分了，一股脑复制过去就行。

scp -r /k8s/etcd/ssl/* root@9.186.102.71:/k8s/etcd/ssl/
scp -r /k8s/etcd/ssl/* root@9.186.102.73:/k8s/etcd/ssl/
```

## 解压并将两个关键的ETCD二进制文件拷贝到对应目录

```
//两个node均需执行。

cd /root/rootpackages/
tar -xvf etcd-v3.3.10-linux-amd64.tar.gz
cd etcd-v3.3.10-linux-amd64/
cp etcd etcdctl /k8s/etcd/bin/
```

## 编辑etcd.conf

```
//两个node均需执行。下面列出两份etcd.conf配置文件。

vi /k8s/etcd/cfg/etcd.conf
```

>> //cloudsec3（第一个普通node，因为master是cloudsec2）上的
```
#[Member]
ETCD_NAME="etcd02"
ETCD_DATA_DIR="/data1/etcd"
###ETCD_LISTEN_PEER_URLS="https://10.2.8.44:2380"
###ETCD_LISTEN_CLIENT_URLS="https://10.2.8.44:2379"
ETCD_LISTEN_PEER_URLS="https://9.186.102.71:2380"
ETCD_LISTEN_CLIENT_URLS="https://9.186.102.71:2379"
 
#[Clustering]
###ETCD_INITIAL_ADVERTISE_PEER_URLS="https://10.2.8.44:2380"
###ETCD_ADVERTISE_CLIENT_URLS="https://10.2.8.44:2379"
###ETCD_INITIAL_CLUSTER="etcd01=https://10.2.8.44:2380,etcd02=https://10.2.8.65:2380,etcd03=https://10.2.8.34:2380"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://9.186.102.71:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://9.186.102.71:2379"
ETCD_INITIAL_CLUSTER="etcd01=https://9.186.102.196:2380,etcd02=https://9.186.102.71:2380,etcd03=https://9.186.102.73:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"

#[Security]
ETCD_CERT_FILE="/k8s/etcd/ssl/server.pem"
ETCD_KEY_FILE="/k8s/etcd/ssl/server-key.pem"
ETCD_TRUSTED_CA_FILE="/k8s/etcd/ssl/ca.pem"
ETCD_CLIENT_CERT_AUTH="true"
ETCD_PEER_CERT_FILE="/k8s/etcd/ssl/server.pem"
ETCD_PEER_KEY_FILE="/k8s/etcd/ssl/server-key.pem"
ETCD_PEER_TRUSTED_CA_FILE="/k8s/etcd/ssl/ca.pem"
ETCD_PEER_CLIENT_CERT_AUTH="true"
```

>> //cloudsec4（第二个普通node）上的
```
#[Member]
ETCD_NAME="etcd03"
ETCD_DATA_DIR="/data1/etcd"
###ETCD_LISTEN_PEER_URLS="https://10.2.8.44:2380"
###ETCD_LISTEN_CLIENT_URLS="https://10.2.8.44:2379"
ETCD_LISTEN_PEER_URLS="https://9.186.102.73:2380"
ETCD_LISTEN_CLIENT_URLS="https://9.186.102.73:2379"
 
#[Clustering]
###ETCD_INITIAL_ADVERTISE_PEER_URLS="https://10.2.8.44:2380"
###ETCD_ADVERTISE_CLIENT_URLS="https://10.2.8.44:2379"
###ETCD_INITIAL_CLUSTER="etcd01=https://10.2.8.44:2380,etcd02=https://10.2.8.65:2380,etcd03=https://10.2.8.34:2380"
ETCD_INITIAL_ADVERTISE_PEER_URLS="https://9.186.102.73:2380"
ETCD_ADVERTISE_CLIENT_URLS="https://9.186.102.73:2379"
ETCD_INITIAL_CLUSTER="etcd01=https://9.186.102.196:2380,etcd02=https://9.186.102.71:2380,etcd03=https://9.186.102.73:2380"
ETCD_INITIAL_CLUSTER_TOKEN="etcd-cluster"
ETCD_INITIAL_CLUSTER_STATE="new"

#[Security]
ETCD_CERT_FILE="/k8s/etcd/ssl/server.pem"
ETCD_KEY_FILE="/k8s/etcd/ssl/server-key.pem"
ETCD_TRUSTED_CA_FILE="/k8s/etcd/ssl/ca.pem"
ETCD_CLIENT_CERT_AUTH="true"
ETCD_PEER_CERT_FILE="/k8s/etcd/ssl/server.pem"
ETCD_PEER_KEY_FILE="/k8s/etcd/ssl/server-key.pem"
ETCD_PEER_TRUSTED_CA_FILE="/k8s/etcd/ssl/ca.pem"
ETCD_PEER_CLIENT_CERT_AUTH="true"
```

## 创建ETCD的数据目录，编辑etcd.service

```
//两个node均需执行。但下面仅列出一份etcd.service配置文件，因为每个节点都是一样的。

mkdir -p /data1/etcd
vi /usr/lib/systemd/system/etcd.service
```

```
[Unit]
Description=Etcd Server
After=network.target
After=network-online.target
Wants=network-online.target

[Service]
Type=notify
WorkingDirectory=/data1/etcd/
EnvironmentFile=-/k8s/etcd/cfg/etcd.conf
# set GOMAXPROCS to number of processors
ExecStart=/bin/bash -c "GOMAXPROCS=$(nproc) /k8s/etcd/bin/etcd --name=\"${ETCD_NAME}\" --data-dir=\"${ETCD_DATA_DIR}\" --listen-client-urls=\"${ETCD_LISTEN_CLIENT_URLS}\" --listen-peer-urls=\"${ETCD_LISTEN_PEER_URLS}\" --advertise-client-urls=\"${ETCD_ADVERTISE_CLIENT_URLS}\" --initial-cluster-token=\"${ETCD_INITIAL_CLUSTER_TOKEN}\" --initial-cluster=\"${ETCD_INITIAL_CLUSTER}\" --initial-cluster-state=\"${ETCD_INITIAL_CLUSTER_STATE}\" --cert-file=\"${ETCD_CERT_FILE}\" --key-file=\"${ETCD_KEY_FILE}\" --trusted-ca-file=\"${ETCD_TRUSTED_CA_FILE}\" --client-cert-auth=\"${ETCD_CLIENT_CERT_AUTH}\" --peer-cert-file=\"${ETCD_PEER_CERT_FILE}\" --peer-key-file=\"${ETCD_PEER_KEY_FILE}\" --peer-trusted-ca-file=\"${ETCD_PEER_TRUSTED_CA_FILE}\" --peer-client-cert-auth=\"${ETCD_PEER_CLIENT_CERT_AUTH}\""
Restart=on-failure
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
```

>> //至此，两个非master节点的ETCD也安装配置完成，可以回到分隔线前那步启动ETCD集群了。

--------------------------------------------------分隔线：结束--------------------------------------------------

### "4）启动 注意启动前etcd02、etcd03同样配置下"

```
//三个节点均执行。

systemctl daemon-reload
systemctl enable etcd
systemctl start etcd
```

```
//master节点上ETCD服务未启动和启动时的情况。

[root@cloudsec2 ssl]# systemctl status etcd
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: inactive (dead) since Fri 2019-03-01 01:58:12 CST; 29min ago
  Process: 10848 ExecStart=/bin/bash -c GOMAXPROCS=$(nproc) /k8s/etcd/bin/etcd --name="${ETCD_NAME}" --data-dir="${ETCD_DATA_DI                           R}" --listen-client-urls="${ETCD_LISTEN_CLIENT_URLS}" --listen-peer-urls="${ETCD_LISTEN_PEER_URLS}" --advertise-client-urls="${                           ETCD_ADVERTISE_CLIENT_URLS}" --initial-cluster-token="${ETCD_INITIAL_CLUSTER_TOKEN}" --initial-cluster="${ETCD_INITIAL_CLUSTER}                           " --initial-cluster-state="${ETCD_INITIAL_CLUSTER_STATE}" --cert-file="${ETCD_CERT_FILE}" --key-file="${ETCD_KEY_FILE}" --trust                           ed-ca-file="${ETCD_TRUSTED_CA_FILE}" --client-cert-auth="${ETCD_CLIENT_CERT_AUTH}" --peer-cert-file="${ETCD_PEER_CERT_FILE}" --                           peer-key-file="${ETCD_PEER_KEY_FILE}" --peer-trusted-ca-file="${ETCD_PEER_TRUSTED_CA_FILE}" --peer-client-cert-auth="${ETCD_PEE                           R_CLIENT_CERT_AUTH}" (code=killed, signal=TERM)
 Main PID: 10848 (code=killed, signal=TERM)

Mar 01 01:58:09 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a became candidate at term 318
Mar 01 01:58:09 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a received MsgVoteResp from 36edec0e35ae429a at ... 318
Mar 01 01:58:09 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a [logterm: 1, index: 3] sent MsgVote request to... 318
Mar 01 01:58:09 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a [logterm: 1, index: 3] sent MsgVote request to... 318
Mar 01 01:58:11 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a is starting a new election at term 318
Mar 01 01:58:11 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a became candidate at term 319
Mar 01 01:58:11 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a received MsgVoteResp from 36edec0e35ae429a at ... 319
Mar 01 01:58:11 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a [logterm: 1, index: 3] sent MsgVote request to... 319
Mar 01 01:58:11 cloudsec2.sl.cloud9.ibm.com etcd[10848]: 36edec0e35ae429a [logterm: 1, index: 3] sent MsgVote request to... 319
Mar 01 01:58:12 cloudsec2.sl.cloud9.ibm.com systemd[1]: Stopped Etcd Server.
Hint: Some lines were ellipsized, use -l to show in full.


[root@cloudsec2 ssl]# systemctl start etcd
[root@cloudsec2 ssl]# systemctl status etcd
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2019-03-01 02:28:00 CST; 3s ago
 Main PID: 25177 (etcd)
   CGroup: /system.slice/etcd.service
           └─25177 /k8s/etcd/bin/etcd --name=etcd01 --data-dir=/data1/etcd --listen-client-urls=https://9.186.102.196:2379 -...

Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: established a TCP streaming connection with peer 91dc3b34b572a3...der)
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: set the initial cluster version to 3.0
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: enabled capabilities for version 3.0
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: published {Name:etcd01 ClientURLs:[https://9.186.102.196:2379]}...fa68
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: ready to serve client requests
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: serving client requests on 9.186.102.196:2379
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com systemd[1]: Started Etcd Server.
Mar 01 02:28:00 cloudsec2.sl.cloud9.ibm.com etcd[25177]: 36edec0e35ae429a initialzed peer connection; fast-forwarding 8 ...r(s)
Mar 01 02:28:01 cloudsec2.sl.cloud9.ibm.com etcd[25177]: updated the cluster version from 3.0 to 3.3
Mar 01 02:28:01 cloudsec2.sl.cloud9.ibm.com etcd[25177]: enabled capabilities for version 3.3
Hint: Some lines were ellipsized, use -l to show in full.
```

```
//第一个非master节点上只记下了成功后的提示了。。。

[root@cloudsec3 ssl]# systemctl status etcd
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2019-03-01 02:25:01 CST; 1h 29min ago
 Main PID: 31988 (etcd)
   CGroup: /system.slice/etcd.service
           └─31988 /k8s/etcd/bin/etcd --name=etcd02 --data-dir=/data1/etcd --listen-client-urls=https://9.186.102.71:2379 --listen-peer-urls=https://9....

Mar 01 02:27:57 cloudsec3.sl.cloud9.ibm.com etcd[31988]: failed to reach the peerURL(https://9.186.102.196:2380) of member 36edec0e35ae429a (Get...efused)
Mar 01 02:27:57 cloudsec3.sl.cloud9.ibm.com etcd[31988]: cannot get the version of member 36edec0e35ae429a (Get https://9.186.102.196:2380/versi...efused)
Mar 01 02:28:00 cloudsec3.sl.cloud9.ibm.com etcd[31988]: peer 36edec0e35ae429a became active
Mar 01 02:28:00 cloudsec3.sl.cloud9.ibm.com etcd[31988]: established a TCP streaming connection with peer 36edec0e35ae429a (stream MsgApp v2 reader)
Mar 01 02:28:00 cloudsec3.sl.cloud9.ibm.com etcd[31988]: established a TCP streaming connection with peer 36edec0e35ae429a (stream Message reader)
Mar 01 02:28:00 cloudsec3.sl.cloud9.ibm.com etcd[31988]: established a TCP streaming connection with peer 36edec0e35ae429a (stream MsgApp v2 writer)
Mar 01 02:28:00 cloudsec3.sl.cloud9.ibm.com etcd[31988]: established a TCP streaming connection with peer 36edec0e35ae429a (stream Message writer)
Mar 01 02:28:01 cloudsec3.sl.cloud9.ibm.com etcd[31988]: updating the cluster version from 3.0 to 3.3
Mar 01 02:28:01 cloudsec3.sl.cloud9.ibm.com etcd[31988]: updated the cluster version from 3.0 to 3.3
Mar 01 02:28:01 cloudsec3.sl.cloud9.ibm.com etcd[31988]: enabled capabilities for version 3.3
Hint: Some lines were ellipsized, use -l to show in full.
```

```
//第二个非master节点似乎有点问题，后面重启了下好了？

[root@cloudsec4 ssl]# systemctl status etcd
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2019-03-01 02:25:01 CST; 1min 45s ago
 Main PID: 1003 (etcd)
   CGroup: /system.slice/etcd.service
           └─1003 /k8s/etcd/bin/etcd --name=etcd03 --data-dir=/data1/etcd --listen-client-urls=https://9.186.102.73:2379 --l...

Mar 01 02:26:26 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...HOT")
Mar 01 02:26:26 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...AGE")
Mar 01 02:26:31 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...HOT")
Mar 01 02:26:31 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...AGE")
Mar 01 02:26:36 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...HOT")
Mar 01 02:26:36 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...AGE")
Mar 01 02:26:41 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...HOT")
Mar 01 02:26:41 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...AGE")
Mar 01 02:26:46 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...HOT")
Mar 01 02:26:46 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial ...AGE")
Hint: Some lines were ellipsized, use -l to show in full.


[root@cloudsec4 ssl]# systemctl status etcd -l --no-pager
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2019-03-01 02:25:01 CST; 1min 55s ago
 Main PID: 1003 (etcd)
   CGroup: /system.slice/etcd.service
           └─1003 /k8s/etcd/bin/etcd --name=etcd03 --data-dir=/data1/etcd --listen-client-urls=https://9.186.102.73:2379 --list                           en-peer-urls=https://9.186.102.73:2380 --advertise-client-urls=https://9.186.102.73:2379 --initial-cluster-token=etcd-cluster -                           -initial-cluster=etcd01=https://9.186.102.196:2380,etcd02=https://9.186.102.71:2380,etcd03=https://9.186.102.73:2380 --initial-                           cluster-state=new --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --trusted-ca-file=/k8s/etcd/ssl/                           ca.pem --client-cert-auth=true --peer-cert-file=/k8s/etcd/ssl/server.pem --peer-key-file=/k8s/etcd/ssl/server-key.pem --peer-tr                           usted-ca-file=/k8s/etcd/ssl/ca.pem --peer-client-cert-auth=true

Mar 01 02:26:36 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_SNAPSHOT")
Mar 01 02:26:36 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_RAFT_MESSAGE")
Mar 01 02:26:41 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_SNAPSHOT")
Mar 01 02:26:41 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_RAFT_MESSAGE")
Mar 01 02:26:46 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_SNAPSHOT")
Mar 01 02:26:46 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_RAFT_MESSAGE")
Mar 01 02:26:51 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_SNAPSHOT")
Mar 01 02:26:51 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_RAFT_MESSAGE")
Mar 01 02:26:56 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_SNAPSHOT")
Mar 01 02:26:56 cloudsec4.sl.cloud9.ibm.com etcd[1003]: health check for peer 36edec0e35ae429a could not connect: dial tcp 9.18                           6.102.196:2380: connect: connection refused (prober "ROUND_TRIPPER_RAFT_MESSAGE")


[root@cloudsec4 ssl]# systemctl restart etcd
[root@cloudsec4 ssl]# systemctl status etcd -l --no-pager
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: active (running) since Fri 2019-03-01 02:27:11 CST; 2s ago
 Main PID: 2150 (etcd)
   CGroup: /system.slice/etcd.service
           └─2150 /k8s/etcd/bin/etcd --name=etcd03 --data-dir=/data1/etcd --listen-client-urls=https://9.186.102.73:2379 --list                           en-peer-urls=https://9.186.102.73:2380 --advertise-client-urls=https://9.186.102.73:2379 --initial-cluster-token=etcd-cluster -                           -initial-cluster=etcd01=https://9.186.102.196:2380,etcd02=https://9.186.102.71:2380,etcd03=https://9.186.102.73:2380 --initial-                           cluster-state=new --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --trusted-ca-file=/k8s/etcd/ssl/                           ca.pem --client-cert-auth=true --peer-cert-file=/k8s/etcd/ssl/server.pem --peer-key-file=/k8s/etcd/ssl/server-key.pem --peer-tr                           usted-ca-file=/k8s/etcd/ssl/ca.pem --peer-client-cert-auth=true

Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: peer 12bcf8a55ccaf5c8 became active
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: established a TCP streaming connection with peer 12bcf8a55ccaf5c8 (stre                           am Message reader)
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: established a TCP streaming connection with peer 12bcf8a55ccaf5c8 (stre                           am MsgApp v2 reader)
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: raft.node: 91dc3b34b572a3eb elected leader 12bcf8a55ccaf5c8 at term 5
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: established a TCP streaming connection with peer 12bcf8a55ccaf5c8 (stre                           am MsgApp v2 writer)
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: published {Name:etcd03 ClientURLs:[https://9.186.102.73:2379]} to clust                           er 1d489f28292ffa68
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: ready to serve client requests
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com systemd[1]: Started Etcd Server.
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: serving client requests on 9.186.102.73:2379
Mar 01 02:27:11 cloudsec4.sl.cloud9.ibm.com etcd[2150]: established a TCP streaming connection with peer 12bcf8a55ccaf5c8 (stre                           am Message writer)
```

### "5）服务检查"

```
[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" cluster-health
member 12bcf8a55ccaf5c8 is healthy: got healthy result from https://9.186.102.71:2379
member 36edec0e35ae429a is healthy: got healthy result from https://9.186.102.196:2379
member 91dc3b34b572a3eb is healthy: got healthy result from https://9.186.102.73:2379
cluster is healthy
```

```
[root@cloudsec2 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" member list
12bcf8a55ccaf5c8: name=etcd02 peerURLs=https://9.186.102.71:2380 clientURLs=https://9.186.102.71:2379 isLeader=false
36edec0e35ae429a: name=etcd01 peerURLs=https://9.186.102.196:2380 clientURLs=https://9.186.102.196:2379 isLeader=false
91dc3b34b572a3eb: name=etcd03 peerURLs=https://9.186.102.73:2380 clientURLs=https://9.186.102.73:2379 isLeader=true
```

### 试试ETCD

```
//试试不带那一堆参数执行ETCD的命令

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl member list
Error:  client: etcd cluster is unavailable or misconfigured; error #0: dial tcp 127.0.0.1:4001: connect: connection refused
; error #1: dial tcp 127.0.0.1:2379: connect: connection refused

error #0: dial tcp 127.0.0.1:4001: connect: connection refused
error #1: dial tcp 127.0.0.1:2379: connect: connection refused


[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl cluster-health
cluster may be unhealthy: failed to list members
Error:  client: etcd cluster is unavailable or misconfigured; error #0: dial tcp 127.0.0.1:2379: connect: connection refused
; error #1: dial tcp 127.0.0.1:4001: connect: connection refused

error #0: dial tcp 127.0.0.1:2379: connect: connection refused
error #1: dial tcp 127.0.0.1:4001: connect: connection refused


//只是不指定--endpoints就会连接到本地

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem cluster-health                                                                                          cluster may be unhealthy: failed to list members
Error:  client: etcd cluster is unavailable or misconfigured; error #0: dial tcp 127.0.0.1:2379: connect: connection refused
; error #1: dial tcp 127.0.0.1:4001: connect: connection refused

error #0: dial tcp 127.0.0.1:2379: connect: connection refused
error #1: dial tcp 127.0.0.1:4001: connect: connection refused

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem member list                                                                                             Error:  client: etcd cluster is unavailable or misconfigured; error #0: dial tcp 127.0.0.1:2379: connect: connection refused
; error #1: dial tcp 127.0.0.1:4001: connect: connection refused

error #0: dial tcp 127.0.0.1:2379: connect: connection refused
error #1: dial tcp 127.0.0.1:4001: connect: connection refused


//只是不指定证书就会报"x509: certificate signed by unknown authority"

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" cluster-health                                                                                                         cluster may be unhealthy: failed to list members
Error:  client: etcd cluster is unavailable or misconfigured; error #0: x509: certificate signed by unknown authority
; error #1: x509: certificate signed by unknown authority
; error #2: x509: certificate signed by unknown authority

error #0: x509: certificate signed by unknown authority
error #1: x509: certificate signed by unknown authority
error #2: x509: certificate signed by unknown authority

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" member list
client: etcd cluster is unavailable or misconfigured; error #0: x509: certificate signed by unknown authority
; error #1: x509: certificate signed by unknown authority
; error #2: x509: certificate signed by unknown authority


----------------------------------------------------------------------------------------------------


//在2号机器上杀掉etcd进程

[root@cloudsec2 ~]# pkill etcd
[root@cloudsec2 ~]# systemctl is-active etcd.service
inactive

[root@cloudsec2 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" cluster-health
member 12bcf8a55ccaf5c8 is healthy: got healthy result from https://9.186.102.71:2379
failed to check the health of member 36edec0e35ae429a on https://9.186.102.196:2379: Get https://9.186.102.196:2379/health: dial tcp 9.186.102.196:2379: connect: connection refused
member 36edec0e35ae429a is unreachable: [https://9.186.102.196:2379] are all unreachable
member 91dc3b34b572a3eb is healthy: got healthy result from https://9.186.102.73:2379
cluster is degraded

//在没杀掉etcd的4号机器上看看

[root@cloudsec4 ~]# systemctl is-active etcd.service
active

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" cluster-health
member 12bcf8a55ccaf5c8 is healthy: got healthy result from https://9.186.102.71:2379
failed to check the health of member 36edec0e35ae429a on https://9.186.102.196:2379: Get https://9.186.102.196:2379/health: dial tcp 9.186.102.196:2379: connect: connection refused
member 36edec0e35ae429a is unreachable: [https://9.186.102.196:2379] are all unreachable
member 91dc3b34b572a3eb is healthy: got healthy result from https://9.186.102.73:2379
cluster is degraded

//2号机器重启下etcd（服务）

[root@cloudsec2 ~]# systemctl start etcd
[root@cloudsec2 ~]# systemctl is-active etcd.service
active

[root@cloudsec4 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" cluster-health
member 12bcf8a55ccaf5c8 is healthy: got healthy result from https://9.186.102.71:2379
member 36edec0e35ae429a is healthy: got healthy result from https://9.186.102.196:2379
member 91dc3b34b572a3eb is healthy: got healthy result from https://9.186.102.73:2379
cluster is healthy


----------------------------------------------------------------------------------------------------


//"another etcd process is using "/data1/etcd/member/snap/db" and holds the file lock"
//这个报错似乎是之前用不带参数的ETCD命令启动时，会启动另外一个本地的、单节点的ETCD集群。
//这个本地单节点ETCD集群和预期的三节点ETCD集群最明显的区别是其数据目录是：`/k8s/etcd/ssl/`下的`default.etcd`。
//而不是设定好的/data1/etcd/。所以大概是两套集群都想占error里提到的文件锁导致的？

[root@cloudsec2 bin]# pkill etcd
[root@cloudsec2 bin]# systemctl start etcd
Job for etcd.service failed because a timeout was exceeded. See "systemctl status etcd.service" and "journalctl -xe" for details.
[root@cloudsec2 bin]# systemctl status etcd.service
● etcd.service - Etcd Server
   Loaded: loaded (/usr/lib/systemd/system/etcd.service; enabled; vendor preset: disabled)
   Active: activating (start) since Tue 2019-03-05 03:04:45 CST; 53s ago
 Main PID: 14671 (etcd)
   CGroup: /system.slice/etcd.service
           └─14671 /k8s/etcd/bin/etcd --name=etcd01 --data-dir=/data1/etcd --listen-client-urls=https://9.186.102.196:2379 --listen-peer-urls=https://9...

Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: Git SHA: 27fc7e2
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: Go Version: go1.10.4
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: Go OS/Arch: linux/amd64
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: setting maximum number of CPUs to 4, total number of available CPUs is 4
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: the server is already initialized as member before, starting as etcd member...
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: peerTLS: cert = /k8s/etcd/ssl/server.pem, key = /k8s/etcd/ssl/server-key.pem, ca = , tr...file =
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: listening for peers on https://9.186.102.196:2380
Mar 05 03:04:45 cloudsec2.sl.cloud9.ibm.com etcd[14671]: listening for client requests on 9.186.102.196:2379
Mar 05 03:04:55 cloudsec2.sl.cloud9.ibm.com etcd[14671]: another etcd process is using "/data1/etcd/member/snap/db" and holds the file lock, or ...seconds
Mar 05 03:04:55 cloudsec2.sl.cloud9.ibm.com etcd[14671]: waiting for it to exit before starting...
Hint: Some lines were ellipsized, use -l to show in full.


[root@cloudsec2 default.etcd]# pwd
/k8s/etcd/ssl/default.etcd
[root@cloudsec2 default.etcd]# tree
.
└── member
    ├── snap
    │   └── db
    └── wal
        └── 0000000000000000-0000000000000000.wal


[root@cloudsec2 etcd]# pwd
/data1/etcd
[root@cloudsec2 etcd]# tree
.
└── member
    ├── snap
    │   ├── 0000000000000077-00000000000f424a.snap
    │   ├── 000000000000007c-000000000010c8eb.snap
    │   ├── 000000000000007d-0000000000124f8c.snap
    │   ├── 000000000000008b-000000000013d62d.snap
    │   ├── 000000000000008f-0000000000155cce.snap
    │   └── db
    └── wal
        ├── 0000000000000005-00000000000ac324.wal
        ├── 0000000000000006-00000000000d7362.wal
        ├── 0000000000000007-000000000010239e.wal
        ├── 0000000000000008-000000000012d348.wal
        ├── 0000000000000009-0000000000157f88.wal
        └── 1.tmp

3 directories, 12 files


https://github.com/shunfei/cronsun/issues/90
> 你可能同一台机的多个 etcd 实例用了同一份数据，具体配置参考网上的
```

# 在master节点安装kube-apiserver、kube-scheduler和kube-controller-manager

>> //尽管原帖里直接从`4.5`这个子标题开始，但是我还是更加倾向于给这一部分一个一级标题，因为本身和ETCD的安装是独立的。

## "4.5 生成kubernets证书与私钥"

### "1）制作kubernetes ca证书"

> cd /k8s/kubernetes/ssl

```
cat << EOF | tee ca-config.json
{
  "signing": {
    "default": {
      "expiry": "87600h"
    },
    "profiles": {
      "kubernetes": {
         "expiry": "87600h",
         "usages": [
            "signing",
            "key encipherment",
            "server auth",
            "client auth"
        ]
      }
    }
  }
}
EOF
```

```
cat << EOF | tee ca-csr.json
{
    "CN": "kubernetes",
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF
```

```
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

[root@cloudsec2 ssl]# cfssl gencert -initca ca-csr.json | cfssljson -bare ca -
2019/03/05 03:29:20 [INFO] generating a new CA key and certificate from CSR
2019/03/05 03:29:20 [INFO] generate received request
2019/03/05 03:29:20 [INFO] received CSR
2019/03/05 03:29:20 [INFO] generating key: rsa-2048
2019/03/05 03:29:20 [INFO] encoded CSR
2019/03/05 03:29:20 [INFO] signed certificate with serial number 479898266849027891706526249673753197432758196362
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]# ll
total 20
-rw-r--r--. 1 root root  294 Mar  5 03:28 ca-config.json
-rw-r--r--. 1 root root 1001 Mar  5 03:29 ca.csr
-rw-r--r--. 1 root root  264 Mar  5 03:28 ca-csr.json
-rw-------. 1 root root 1675 Mar  5 03:29 ca-key.pem
-rw-r--r--. 1 root root 1359 Mar  5 03:29 ca.pem
```

### "2）制作apiserver证书"

>> //注意要改3个IP
```
cat << EOF | tee server-csr.json
{
    "CN": "kubernetes",
    "hosts": [
      "10.254.0.1",
      "127.0.0.1",
      "9.186.102.196",
      "9.186.102.71",
      "9.186.102.73",
      "kubernetes",
      "kubernetes.default",
      "kubernetes.default.svc",
      "kubernetes.default.svc.cluster",
      "kubernetes.default.svc.cluster.local"
    ],
    "key": {
        "algo": "rsa",
        "size": 2048
    },
    "names": [
        {
            "C": "CN",
            "L": "Beijing",
            "ST": "Beijing",
            "O": "k8s",
            "OU": "System"
        }
    ]
}
EOF
```

```
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes server-csr.json | cfssljson -bare server

[root@cloudsec2 ssl]# cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes server-csr.json | cfssljson -bare server
2019/03/05 04:02:45 [INFO] generate received request
2019/03/05 04:02:45 [INFO] received CSR
2019/03/05 04:02:45 [INFO] generating key: rsa-2048
2019/03/05 04:02:45 [INFO] encoded CSR
2019/03/05 04:02:45 [INFO] signed certificate with serial number 343727815894778081107506761485761041672444643055
2019/03/05 04:02:45 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]# ll
total 36
-rw-r--r--. 1 root root  294 Mar  5 03:28 ca-config.json
-rw-r--r--. 1 root root 1001 Mar  5 03:29 ca.csr
-rw-r--r--. 1 root root  264 Mar  5 03:28 ca-csr.json
-rw-------. 1 root root 1675 Mar  5 03:29 ca-key.pem
-rw-r--r--. 1 root root 1359 Mar  5 03:29 ca.pem
-rw-r--r--. 1 root root 1261 Mar  5 04:02 server.csr
-rw-r--r--. 1 root root  557 Mar  5 04:02 server-csr.json
-rw-------. 1 root root 1679 Mar  5 04:02 server-key.pem
-rw-r--r--. 1 root root 1627 Mar  5 04:02 server.pem
```

### "3）制作kube-proxy证书"

```
cat << EOF | tee kube-proxy-csr.json
{
  "CN": "system:kube-proxy",
  "hosts": [],
  "key": {
    "algo": "rsa",
    "size": 2048
  },
  "names": [
    {
      "C": "CN",
      "L": "Beijing",
      "ST": "Beijing",
      "O": "k8s",
      "OU": "System"
    }
  ]
}
EOF
```

```
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy

[root@cloudsec2 ssl]# cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=kubernetes kube-proxy-csr.json | cfssljson -bare kube-proxy
2019/03/05 04:04:21 [INFO] generate received request
2019/03/05 04:04:21 [INFO] received CSR
2019/03/05 04:04:21 [INFO] generating key: rsa-2048
2019/03/05 04:04:22 [INFO] encoded CSR
2019/03/05 04:04:22 [INFO] signed certificate with serial number 595287392723815868592864313408942468445783741283
2019/03/05 04:04:22 [WARNING] This certificate lacks a "hosts" field. This makes it unsuitable for
websites. For more information see the Baseline Requirements for the Issuance and Management
of Publicly-Trusted Certificates, v.1.1.6, from the CA/Browser Forum (https://cabforum.org);
specifically, section 10.2.3 ("Information Requirements").
[root@cloudsec2 ssl]#
[root@cloudsec2 ssl]# ll
total 52
-rw-r--r--. 1 root root  294 Mar  5 03:28 ca-config.json
-rw-r--r--. 1 root root 1001 Mar  5 03:29 ca.csr
-rw-r--r--. 1 root root  264 Mar  5 03:28 ca-csr.json
-rw-------. 1 root root 1675 Mar  5 03:29 ca-key.pem
-rw-r--r--. 1 root root 1359 Mar  5 03:29 ca.pem
-rw-r--r--. 1 root root 1009 Mar  5 04:04 kube-proxy.csr
-rw-r--r--. 1 root root  230 Mar  5 04:04 kube-proxy-csr.json
-rw-------. 1 root root 1675 Mar  5 04:04 kube-proxy-key.pem
-rw-r--r--. 1 root root 1403 Mar  5 04:04 kube-proxy.pem
-rw-r--r--. 1 root root 1261 Mar  5 04:02 server.csr
-rw-r--r--. 1 root root  557 Mar  5 04:02 server-csr.json
-rw-------. 1 root root 1679 Mar  5 04:02 server-key.pem
-rw-r--r--. 1 root root 1627 Mar  5 04:02 server.pem
```

## "4.6部署kubernetes server"

### "1）解压缩文件"

```
// 攻略里没提的trivial步骤，总得先进到kubernetes server安装包在的目录吧
cd /root/rootpackages/

tar -zxvf kubernetes-server-linux-amd64.tar.gz 
cd kubernetes/server/bin/
cp kube-scheduler kube-apiserver kube-controller-manager kubectl /k8s/kubernetes/bin/
```

### "2）部署kube-apiserver组件 创建TLS Bootstrapping Token"

```
//注意因为用了urandom，所以这里自己生成的随机串和原帖里的肯定不一样。

[root@cloudsec2 bin]# head -c 16 /dev/urandom | od -An -t x | tr -d ' '
a7be4d31d97e5e9731237f05d2bbd46a

[root@cloudsec2 bin]# vi /k8s/kubernetes/cfg/token.csv
``
a7be4d31d97e5e9731237f05d2bbd46a,kubelet-bootstrap,10001,"system:kubelet-bootstrap"
``
```

#### "创建Apiserver配置文件"

> [root@cloudsec2 bin]# vi /k8s/kubernetes/cfg/kube-apiserver
```
KUBE_APISERVER_OPTS="--logtostderr=true \
--v=4 \
--etcd-servers=https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379 \
--bind-address=9.186.102.196 \
--secure-port=6443 \
--advertise-address=9.186.102.196 \
--allow-privileged=true \
--service-cluster-ip-range=10.254.0.0/16 \
--enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,ResourceQuota,NodeRestriction \
--authorization-mode=RBAC,Node \
--enable-bootstrap-token-auth \
--token-auth-file=/k8s/kubernetes/cfg/token.csv \
--service-node-port-range=30000-50000 \
--tls-cert-file=/k8s/kubernetes/ssl/server.pem  \
--tls-private-key-file=/k8s/kubernetes/ssl/server-key.pem \
--client-ca-file=/k8s/kubernetes/ssl/ca.pem \
--service-account-key-file=/k8s/kubernetes/ssl/ca-key.pem \
--etcd-cafile=/k8s/etcd/ssl/ca.pem \
--etcd-certfile=/k8s/etcd/ssl/server.pem \
--etcd-keyfile=/k8s/etcd/ssl/server-key.pem"
```
>> //注意此处只需更改三行的IP，10.254.0.0/16那个不用改。

#### "创建apiserver systemd文件"

> [root@cloudsec2 bin]# vi /usr/lib/systemd/system/kube-apiserver.service
```
[Unit]
Description=Kubernetes API Server
Documentation=https://github.com/kubernetes/kubernetes
 
[Service]
EnvironmentFile=-/k8s/kubernetes/cfg/kube-apiserver
ExecStart=/k8s/kubernetes/bin/kube-apiserver $KUBE_APISERVER_OPTS
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
```

#### "启动服务"

```
systemctl daemon-reload
systemctl enable kube-apiserver
systemctl start kube-apiserver

[root@cloudsec2 bin]# systemctl daemon-reload
[root@cloudsec2 bin]# systemctl enable kube-apiserver
Created symlink from /etc/systemd/system/multi-user.target.wants/kube-apiserver.service to /usr/lib/systemd/system/kube-apiserver.service.
[root@cloudsec2 bin]# systemctl start kube-apiserver
```

```
//这个是第一次IP没改过来，掉了一次坑，看报错："error: failed to create listener: failed to listen on 10.2.8.44:6443"

[root@cloudsec2 bin]# systemctl status kube-apiserver
● kube-apiserver.service - Kubernetes API Server
   Loaded: loaded (/usr/lib/systemd/system/kube-apiserver.service; enabled; vendor preset: disabled)
   Active: failed (Result: start-limit) since Tue 2019-03-05 04:29:15 CST; 3min 47s ago
     Docs: https://github.com/kubernetes/kubernetes
  Process: 23330 ExecStart=/k8s/kubernetes/bin/kube-apiserver $KUBE_APISERVER_OPTS (code=exited, status=1/FAILURE)
 Main PID: 23330 (code=exited, status=1/FAILURE)

Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com kube-apiserver[23330]: -v, --v Level                          log level for V logs (default 0)
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com kube-apiserver[23330]: --version version[=true]           Print version information and quit
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com kube-apiserver[23330]: --vmodule moduleSpec               comma-separated list of pattern=N settings ...ogging
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com kube-apiserver[23330]: error: failed to create listener: failed to listen on 10.2.8.44:6443: listen t...ddress
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com systemd[1]: kube-apiserver.service holdoff time over, scheduling restart.
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com systemd[1]: Stopped Kubernetes API Server.
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com systemd[1]: start request repeated too quickly for kube-apiserver.service
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com systemd[1]: Failed to start Kubernetes API Server.
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com systemd[1]: Unit kube-apiserver.service entered failed state.
Mar 05 04:29:15 cloudsec2.sl.cloud9.ibm.com systemd[1]: kube-apiserver.service failed.
Hint: Some lines were ellipsized, use -l to show in full.

[root@cloudsec2 bin]# systemctl is-active kube-apiserver
failed
```

```
[root@cloudsec2 bin]# systemctl start kube-apiserver
[root@cloudsec2 bin]# systemctl status kube-apiserver
● kube-apiserver.service - Kubernetes API Server
   Loaded: loaded (/usr/lib/systemd/system/kube-apiserver.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2019-03-05 04:58:12 CST; 5min ago
     Docs: https://github.com/kubernetes/kubernetes
 Main PID: 4784 (kube-apiserver)
    Tasks: 13
   Memory: 264.9M
   CGroup: /system.slice/kube-apiserver.service
           └─4784 /k8s/kubernetes/bin/kube-apiserver --logtostderr=true --v=4 --etcd-servers=https://9.186.102.196:2379,https://9.186.102.71:2379,https...

Mar 05 05:03:52 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:52.626351    4784 wrap.go:47] GET /apis/coordination.k8s.io/v1beta1…6:48076]
Mar 05 05:03:53 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:53.309397    4784 wrap.go:47] GET /api/v1/namespaces/default: (3.70...48076]
Mar 05 05:03:53 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:53.312947    4784 wrap.go:47] GET /api/v1/namespaces/default/servic...48076]
Mar 05 05:03:53 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:53.327478    4784 wrap.go:47] GET /api/v1/namespaces/default/endpoi...48076]
Mar 05 05:03:53 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:53.404046    4784 wrap.go:47] GET /apis/admissionregistration.k8s.i...48076]
Mar 05 05:03:53 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:53.404246    4784 reflector.go:357] k8s.io/client-go/informers/fact...ceived
Mar 05 05:03:53 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:03:53.404809    4784 get.go:247] Starting watch for /apis/admissionreg...t=8m5s
Mar 05 05:04:03 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:04:03.333981    4784 wrap.go:47] GET /api/v1/namespaces/default: (3.11...48076]
Mar 05 05:04:03 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:04:03.337294    4784 wrap.go:47] GET /api/v1/namespaces/default/servic...48076]
Mar 05 05:04:03 cloudsec2.sl.cloud9.ibm.com kube-apiserver[4784]: I0305 05:04:03.348536    4784 wrap.go:47] GET /api/v1/namespaces/default/endpoi...48076]
Hint: Some lines were ellipsized, use -l to show in full.

[root@cloudsec2 bin]# ps -ef | grep kube-apiserver
root      4784     1  4 04:58 ?        00:00:20 /k8s/kubernetes/bin/kube-apiserver --logtostderr=true --v=4 --etcd-servers=https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379 --bind-address=9.186.102.196 --secure-port=6443 --advertise-address=9.186.102.196 --allow-privileged=true --service-cluster-ip-range=10.254.0.0/16 --enable-admission-plugins=NamespaceLifecycle,LimitRanger,ServiceAccount,ResourceQuota,NodeRestriction --authorization-mode=RBAC,Node --enable-bootstrap-token-auth --token-auth-file=/k8s/kubernetes/cfg/token.csv --service-node-port-range=30000-50000 --tls-cert-file=/k8s/kubernetes/ssl/server.pem --tls-private-key-file=/k8s/kubernetes/ssl/server-key.pem --client-ca-file=/k8s/kubernetes/ssl/ca.pem --service-account-key-file=/k8s/kubernetes/ssl/ca-key.pem --etcd-cafile=/k8s/etcd/ssl/ca.pem --etcd-certfile=/k8s/etcd/ssl/server.pem --etcd-keyfile=/k8s/etcd/ssl/server-key.pem
root      8410 17966  0 05:05 pts/0    00:00:00 grep --color=auto kube-apiserver

[root@cloudsec2 bin]# netstat -tulpn | grep kube-apiserve
tcp        0      0 9.186.102.196:6443      0.0.0.0:*               LISTEN      4784/kube-apiserver
tcp        0      0 127.0.0.1:8080          0.0.0.0:*               LISTEN      4784/kube-apiserver
```

### "3）部署kube-scheduler组件 创建kube-scheduler配置文件"

> [root@cloudsec2 bin]# vi /k8s/kubernetes/cfg/kube-scheduler
```
KUBE_SCHEDULER_OPTS="--logtostderr=true --v=4 --master=127.0.0.1:8080 --leader-elect"
```

#### "创建kube-scheduler systemd文件"

> [root@cloudsec2 kubernetes]# vi /usr/lib/systemd/system/kube-scheduler.service
```
[Unit]
Description=Kubernetes Scheduler
Documentation=https://github.com/kubernetes/kubernetes
 
[Service]
EnvironmentFile=-/k8s/kubernetes/cfg/kube-scheduler
ExecStart=/k8s/kubernetes/bin/kube-scheduler $KUBE_SCHEDULER_OPTS
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
```

#### "启动服务"

```
systemctl daemon-reload
systemctl enable kube-scheduler.service 
systemctl start kube-scheduler.service

[root@cloudsec2 kubernetes]# systemctl daemon-reload
[root@cloudsec2 kubernetes]# systemctl enable kube-scheduler.service
Created symlink from /etc/systemd/system/multi-user.target.wants/kube-scheduler.service to /usr/lib/systemd/system/kube-scheduler.service.
[root@cloudsec2 kubernetes]# systemctl start kube-scheduler.service
[root@cloudsec2 kubernetes]# systemctl status kube-scheduler.service
● kube-scheduler.service - Kubernetes Scheduler
   Loaded: loaded (/usr/lib/systemd/system/kube-scheduler.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2019-03-05 05:41:26 CST; 24s ago
     Docs: https://github.com/kubernetes/kubernetes
 Main PID: 27121 (kube-scheduler)
    Tasks: 13
   Memory: 12.9M
   CGroup: /system.slice/kube-scheduler.service
           └─27121 /k8s/kubernetes/bin/kube-scheduler --logtostderr=true --v=4 --master=127.0.0.1:8080 --leader-elect

Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.230451   27121 shared_informer.go:123] caches populated
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.330615   27121 shared_informer.go:123] caches populated
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.430897   27121 shared_informer.go:123] caches populated
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.531114   27121 shared_informer.go:123] caches populated
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.531157   27121 controller_utils.go:1027] Waiting for caches to ...roller
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.631423   27121 shared_informer.go:123] caches populated
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.631449   27121 controller_utils.go:1034] Caches are synced for ...roller
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.631485   27121 leaderelection.go:205] attempting to acquire lea...ler...
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.643234   27121 leaderelection.go:214] successfully acquired lea...eduler
Mar 05 05:41:28 cloudsec2.sl.cloud9.ibm.com kube-scheduler[27121]: I0305 05:41:28.744034   27121 shared_informer.go:123] caches populated
Hint: Some lines were ellipsized, use -l to show in full.
```

### "4）部署kube-controller-manager组件 创建kube-controller-manager配置文件"

> [root@cloudsec2 kubernetes]# vi /k8s/kubernetes/cfg/kube-controller-manager
```
KUBE_CONTROLLER_MANAGER_OPTS="--logtostderr=true \
--v=4 \
--master=127.0.0.1:8080 \
--leader-elect=true \
--address=127.0.0.1 \
--service-cluster-ip-range=10.254.0.0/16 \
--cluster-name=kubernetes \
--cluster-signing-cert-file=/k8s/kubernetes/ssl/ca.pem \
--cluster-signing-key-file=/k8s/kubernetes/ssl/ca-key.pem  \
--root-ca-file=/k8s/kubernetes/ssl/ca.pem \
--service-account-private-key-file=/k8s/kubernetes/ssl/ca-key.pem"
```

#### "创建kube-controller-manager systemd文件"

> [root@cloudsec2 kubernetes]# vi /usr/lib/systemd/system/kube-controller-manager.service
```
[Unit]
Description=Kubernetes Controller Manager
Documentation=https://github.com/kubernetes/kubernetes
 
[Service]
EnvironmentFile=-/k8s/kubernetes/cfg/kube-controller-manager
ExecStart=/k8s/kubernetes/bin/kube-controller-manager $KUBE_CONTROLLER_MANAGER_OPTS
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
```

#### "启动服务"

```
systemctl daemon-reload
systemctl enable kube-controller-manager
systemctl start kube-controller-manager

[root@cloudsec2 kubernetes]# systemctl daemon-reload
[root@cloudsec2 kubernetes]# systemctl enable kube-controller-manager
Created symlink from /etc/systemd/system/multi-user.target.wants/kube-controller-manager.service to /usr/lib/systemd/system/kube-controller-manager.service.
[root@cloudsec2 kubernetes]# systemctl start kube-controller-manager
[root@cloudsec2 kubernetes]# systemctl status kube-controller-manager
● kube-controller-manager.service - Kubernetes Controller Manager
   Loaded: loaded (/usr/lib/systemd/system/kube-controller-manager.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2019-03-05 05:46:17 CST; 10s ago
     Docs: https://github.com/kubernetes/kubernetes
 Main PID: 29706 (kube-controller)
    Tasks: 13
   Memory: 44.6M
   CGroup: /system.slice/kube-controller-manager.service
           └─29706 /k8s/kubernetes/bin/kube-controller-manager --logtostderr=true --v=4 --master=127.0.0.1:8080 --leader-elect=true --address=127.0.0.1...

Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.625999   29706 controller_utils.go:1034] Caches are syn...oller
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.626007   29706 garbagecollector.go:142] Garbage collect...rbage
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.660498   29706 request.go:530] Throttling request took ...t=32s
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.661382   29706 resource_quota_controller.go:427] syncin...Resou
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.661563   29706 resource_quota_monitor.go:180] QuotaMoni...icies
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.661599   29706 resource_quota_monitor.go:243] quota syn...ved 0
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: E0305 05:46:20.661615   29706 resource_quota_controller.go:437] failed...cies"
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.710393   29706 shared_informer.go:123] caches populated
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.710419   29706 controller_utils.go:1034] Caches are syn...oller
Mar 05 05:46:20 cloudsec2.sl.cloud9.ibm.com kube-controller-manager[29706]: I0305 05:46:20.710428   29706 garbagecollector.go:245] synced garbage ...ector
Hint: Some lines were ellipsized, use -l to show in full.
```

## "4.7 验证kubeserver服务"

#### "设置环境变量"

```
//不设也没啥 --> 后来直接用软链接了。

vim /etc/profile
PATH=/k8s/kubernetes/bin:$PATH
source /etc/profile
```

#### "查看master服务状态"

```
[root@cloudsec2 kubernetes]# /k8s/kubernetes/bin/kubectl get cs,nodes
NAME                                 STATUS    MESSAGE             ERROR
componentstatus/controller-manager   Healthy   ok
componentstatus/scheduler            Healthy   ok
componentstatus/etcd-0               Healthy   {"health":"true"}
componentstatus/etcd-1               Healthy   {"health":"true"}
componentstatus/etcd-2               Healthy   {"health":"true"}
```

# "五、Node部署" --> 也就是在两个非master节点安装docker、kubelet、kube-proxy、flannel

>> //开始第二个节点了，之前master已经完了，也正常了。现在是第一个普通k8s节点，另外一个跟这个对称

## "5.1 Docker环境安装"

之前已装过，略。

## "5.2 部署kubelet组件"

### "1）安装二进制文件"

```
wget https://dl.k8s.io/v1.13.1/kubernetes-node-linux-amd64.tar.gz
tar zxvf kubernetes-node-linux-amd64.tar.gz
cd kubernetes/node/bin/
cp kube-proxy kubelet kubectl /k8s/kubernetes/bin/
```

### "2）复制相关证书到node节点"

>> //这一步当然要切回master节点做
```
[root@cloudsec2 ssl]# cd /k8s/kubernetes/ssl/
[root@cloudsec2 ssl]# ll
total 52
-rw-r--r--. 1 root root  294 Mar  5 03:28 ca-config.json
-rw-r--r--. 1 root root 1001 Mar  5 03:29 ca.csr
-rw-r--r--. 1 root root  264 Mar  5 03:28 ca-csr.json
-rw-------. 1 root root 1675 Mar  5 03:29 ca-key.pem
-rw-r--r--. 1 root root 1359 Mar  5 03:29 ca.pem
-rw-r--r--. 1 root root 1009 Mar  5 04:04 kube-proxy.csr
-rw-r--r--. 1 root root  230 Mar  5 04:04 kube-proxy-csr.json
-rw-------. 1 root root 1675 Mar  5 04:04 kube-proxy-key.pem
-rw-r--r--. 1 root root 1403 Mar  5 04:04 kube-proxy.pem
-rw-r--r--. 1 root root 1261 Mar  5 04:02 server.csr
-rw-r--r--. 1 root root  557 Mar  5 04:02 server-csr.json
-rw-------. 1 root root 1679 Mar  5 04:02 server-key.pem
-rw-r--r--. 1 root root 1627 Mar  5 04:02 server.pem
[root@cloudsec2 ssl]# scp *.pem 9.186.102.71:$PWD
root@9.186.102.71's password:
ca-key.pem                                                                                   100% 1675     2.5MB/s   00:00
ca.pem                                                                                       100% 1359     2.3MB/s   00:00
kube-proxy-key.pem                                                                           100% 1675     3.2MB/s   00:00
kube-proxy.pem                                                                               100% 1403     2.5MB/s   00:00
server-key.pem                                                                               100% 1679     3.0MB/s   00:00
server.pem                                                                                   100% 1627     3.0MB/s   00:00
```

### "3）创建kubelet bootstrap kubeconfig文件 通过脚本实现"

> [root@cloudsec3 ssl]# vi /k8s/kubernetes/cfg/environment.sh
```
#!/bin/bash
#创建kubelet bootstrapping kubeconfig 
###BOOTSTRAP_TOKEN=f2c50331f07be89278acdaf341ff1ecc
###KUBE_APISERVER="https://10.2.8.44:6443"
BOOTSTRAP_TOKEN=a7be4d31d97e5e9731237f05d2bbd46a
KUBE_APISERVER="https://9.186.102.196:6443"
#设置集群参数
kubectl config set-cluster kubernetes \
  --certificate-authority=/k8s/kubernetes/ssl/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=bootstrap.kubeconfig
 
#设置客户端认证参数
kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=bootstrap.kubeconfig
 
# 设置上下文参数
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig
 
# 设置默认上下文
kubectl config use-context default --kubeconfig=bootstrap.kubeconfig
 
#----------------------
 
# 创建kube-proxy kubeconfig文件
 
kubectl config set-cluster kubernetes \
  --certificate-authority=/k8s/kubernetes/ssl/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config set-credentials kube-proxy \
  --client-certificate=/k8s/kubernetes/ssl/kube-proxy.pem \
  --client-key=/k8s/kubernetes/ssl/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
```
>> //注意除了改IP，还要改BOOTSTRAP_TOKEN


#### "执行脚本"

```
[root@cloudsec3 ssl]# cd /k8s/kubernetes/cfg/
[root@cloudsec3 cfg]# sh environment.sh
environment.sh: line 6: kubectl: command not found
environment.sh: line 13: kubectl: command not found
environment.sh: line 18: kubectl: command not found
environment.sh: line 24: kubectl: command not found
environment.sh: line 30: kubectl: command not found
environment.sh: line 36: kubectl: command not found
environment.sh: line 42: kubectl: command not found
environment.sh: line 47: kubectl: command not found
[root@cloudsec3 cfg]# ln -s /k8s/kubernetes/bin/kubectl /usr/local/bin/kubectl
[root@cloudsec3 cfg]# sh environment.sh
Cluster "kubernetes" set.
User "kubelet-bootstrap" set.
Context "default" created.
Switched to context "default".
Cluster "kubernetes" set.
User "kube-proxy" set.
Context "default" created.
Switched to context "default".
[root@cloudsec3 cfg]# ll
total 16
-rw-------. 1 root root 2163 Mar  5 20:42 bootstrap.kubeconfig
-rw-r--r--. 1 root root 1413 Mar  5 20:39 environment.sh
-rw-------. 1 root root 6265 Mar  5 20:42 kube-proxy.kubeconfig
```

### "4）创建kubelet参数配置模板文件"

> [root@cloudsec3 cfg]# vi /k8s/kubernetes/cfg/kubelet.config
```
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
address: 9.186.102.71
port: 10250
readOnlyPort: 10255
cgroupDriver: cgroupfs
clusterDNS: ["10.254.0.10"]
clusterDomain: cluster.local.
failSwapOn: false
authentication:
  anonymous:
    enabled: true
```
>> //改一处IP即可

### "5）创建kubelet配置文件"

> [root@cloudsec3 cfg]# vi /k8s/kubernetes/cfg/kubelet
```
KUBELET_OPTS="--logtostderr=true \
--v=4 \
--hostname-override=9.186.102.71 \
--kubeconfig=/k8s/kubernetes/cfg/kubelet.kubeconfig \
--bootstrap-kubeconfig=/k8s/kubernetes/cfg/bootstrap.kubeconfig \
--config=/k8s/kubernetes/cfg/kubelet.config \
--cert-dir=/k8s/kubernetes/ssl \
--pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0"
```
>> //改一处IP即可
>>> //补充：后来在使用中发现，`--pod-infra-container-image`决定了`pause container`镜像拉取的地址，如果不指定则默认是用`gcr.io`。由于这个攻略是方便国内使用的，所以换成了阿里云的。结果后期我从`quay.io`上自己的仓库拉镜像就会失败，因为我用的公司的Softlayer。所以可以直接不要指定这个flag了，Softlayer访问谷歌镜像没问题。这里只贴一下describe pod时候的部分日志好了————再次强调，**这个是后来发现的，安装过程照着攻略设置这个flag集群启动啥的也都没问题**。下面的错误日志也是**后来使用过程中发现的，和本次安装无关**。
```
Events:
  Type     Reason                  Age                    From                   Message
  ----     ------                  ----                   ----                   -------
  Normal   Scheduled               14m                    default-scheduler      Successfully assigned default/app-operator-6bc585fd46-k6xzc to 9.186.102.71
  Warning  FailedCreatePodSandBox  14m                    kubelet, 9.186.102.71  Failed create pod sandbox: rpc error: code = Unknown desc = failed pulling image "registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0": Error response from daemon: Get https://registry.cn-hangzhou.aliyuncs.com/v2/: net/http: request canceled while waiting for connection (Client.Timeout exceeded while awaiting headers)
  Warning  FailedCreatePodSandBox  14m                    kubelet, 9.186.102.71  Failed create pod sandbox: rpc error: code = Unknown desc = failed pulling image "registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0": Error response from daemon: Get https://registry.cn-hangzhou.aliyuncs.com/v2/: net/http: request canceled (Client.Timeout exceeded while awaiting headers)
  Warning  FailedCreatePodSandBox  11m                    kubelet, 9.186.102.71  Failed create pod sandbox: rpc error: code = Unknown desc = failed pulling image "registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0": Error response from daemon: Get https://registry.cn-hangzhou.aliyuncs.com/v2/google-containers/pause-amd64/manifests/3.0: Get https://dockerauth.cn-hangzhou.aliyuncs.com/auth?scope=repository%3Agoogle-containers%2Fpause-amd64%3Apull&service=registry.aliyuncs.com%3Acn-hangzhou%3A26842: net/http: TLS handshake timeout
  Warning  FailedCreatePodSandBox  4m13s (x4 over 12m)    kubelet, 9.186.102.71  Failed create pod sandbox: rpc error: code = Unknown desc = failed pulling image "registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0": context canceled
  Warning  FailedCreatePodSandBox  3m21s (x2 over 3m47s)  kubelet, 9.186.102.71  Failed create pod sandbox: rpc error: code = Unknown desc = failed pulling image "registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0": Error response from daemon: Get https://registry.cn-hangzhou.aliyuncs.com/v2/: net/http: TLS handshake timeout
  Normal   Pulling                 3m7s                   kubelet, 9.186.102.71  pulling image "quay.io/biaoxyz/app-operator"
  Normal   Pulled                  3m2s                   kubelet, 9.186.102.71  Successfully pulled image "quay.io/biaoxyz/app-operator"
  Normal   Created                 3m2s                   kubelet, 9.186.102.71  Created container
  Normal   Started                 3m1s                   kubelet, 9.186.102.71  Started container
```

### "6）创建kubelet systemd文件"

> [root@cloudsec3 cfg]# vi /usr/lib/systemd/system/kubelet.service
```
[Unit]
Description=Kubernetes Kubelet
After=docker.service
Requires=docker.service
 
[Service]
EnvironmentFile=/k8s/kubernetes/cfg/kubelet
ExecStart=/k8s/kubernetes/bin/kubelet $KUBELET_OPTS
Restart=on-failure
KillMode=process
 
[Install]
WantedBy=multi-user.target
```

### "7）将kubelet-bootstrap用户绑定到系统集群角色"

```
kubectl create clusterrolebinding kubelet-bootstrap \
  --clusterrole=system:node-bootstrapper \
  --user=kubelet-bootstrap


[root@cloudsec3 cfg]# kubectl create clusterrolebinding kubelet-bootstrap --clusterrole=system:node-bootstrapper --user=kubelet-bootstrap
The connection to the server localhost:8080 was refused - did you specify the right host or port?

//结果发现得回到主节点做，所以这里就有个疑问了，三号机器一会还需要这一步吗? --> 貌似这个第7）步后面重复下一个节点的时候就不用了。

[root@cloudsec2 ssl]# kubectl create clusterrolebinding kubelet-bootstrap --clusterrole=system:node-bootstrapper --user=kubelet-bootstrap
-bash: kubectl: command not found
[root@cloudsec2 ssl]# ln -s /k8s/kubernetes/bin/kubectl /usr/local/bin/kubectl
[root@cloudsec2 ssl]# kubectl create clusterrolebinding kubelet-bootstrap --clusterrole=system:node-bootstrapper --user=kubelet-bootstrap
clusterrolebinding.rbac.authorization.k8s.io/kubelet-bootstrap created
```

### "8）启动服务 systemctl daemon-reload systemctl enable kubelet systemctl start kubelet"

```
systemctl daemon-reload 
systemctl enable kubelet 
systemctl start kubelet

[root@cloudsec3 cfg]# systemctl daemon-reload
[root@cloudsec3 cfg]# systemctl enable kubelet
Created symlink from /etc/systemd/system/multi-user.target.wants/kubelet.service to /usr/lib/systemd/system/kubelet.service.
[root@cloudsec3 cfg]# systemctl start kubelet
[root@cloudsec3 cfg]# systemctl status kubelet
● kubelet.service - Kubernetes Kubelet
   Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2019-03-05 21:08:32 CST; 9s ago
 Main PID: 5459 (kubelet)
    Tasks: 11
   Memory: 17.3M
   CGroup: /system.slice/kubelet.service
           └─5459 /k8s/kubernetes/bin/kubelet --logtostderr=true --v=4 --hostname-override=9.186.102.71 --kubeconfig=/k8s/ku...

Mar 05 21:08:32 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:32.458358    5459 feature_gate.go:206] feature ga...p[]}
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.755551    5459 server.go:825] Using self-signe...key)
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777289    5459 mount_linux.go:179] Detected OS...temd
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777351    5459 server.go:407] Version: v1.13.1
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777412    5459 feature_gate.go:206] feature ga...p[]}
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777479    5459 feature_gate.go:206] feature ga...p[]}
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777573    5459 plugins.go:103] No cloud provid...ied.
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777589    5459 server.go:523] No cloud provide...: ""
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.777620    5459 bootstrap.go:65] Using bootstra...file
Mar 05 21:08:33 cloudsec3.sl.cloud9.ibm.com kubelet[5459]: I0305 21:08:33.779759    5459 bootstrap.go:96] No valid priva... one
Hint: Some lines were ellipsized, use -l to show in full.
```

### "9）Master接受kubelet CSR请求 可以手动或自动 approve CSR 请求。推荐使用自动的方式，因为从 v1.8 版本开始，可以自动轮转approve csr 后生成的证书，如下是手动 approve CSR请求操作方法 查看CSR列表"

```
[root@cloudsec3 ~]# kubectl get nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?

//所以得再次回到主节点执行

//原帖没执行这两步get nodes查询，容易让人有点莫名其妙，我多加了这两步主要是想说明：
//----如果不approve csr的话master那边是看不到node的。

[root@cloudsec2 ssl]# kubectl get nodes
No resources found.

[root@cloudsec2 ssl]# kubectl get csr
NAME                                                   AGE     REQUESTOR           CONDITION
node-csr-EgB43eNgoMDQhAQjUgfL9FjVWcTpEpo2w4dxsZAq2VY   4m48s   kubelet-bootstrap   Pending

[root@cloudsec2 ssl]# kubectl certificate approve node-csr-EgB43eNgoMDQhAQjUgfL9FjVWcTpEpo2w4dxsZAq2VY
certificatesigningrequest.certificates.k8s.io/node-csr-EgB43eNgoMDQhAQjUgfL9FjVWcTpEpo2w4dxsZAq2VY approved

[root@cloudsec2 ssl]# kubectl get csr
NAME                                                   AGE     REQUESTOR           CONDITION
node-csr-EgB43eNgoMDQhAQjUgfL9FjVWcTpEpo2w4dxsZAq2VY   5m25s   kubelet-bootstrap   Approved,Issued

[root@cloudsec2 ssl]# kubectl get nodes
NAME           STATUS   ROLES    AGE   VERSION
9.186.102.71   Ready    <none>   23s   v1.13.1
```

## "5.3部署kube-proxy组件"

### "1）创建 kube-proxy 配置文件"

> [root@cloudsec3 cfg]# vi /k8s/kubernetes/cfg/kube-proxy
```
KUBE_PROXY_OPTS="--logtostderr=true \
--v=4 \
--hostname-override=9.186.102.71 \
--cluster-cidr=10.254.0.0/16 \
--kubeconfig=/k8s/kubernetes/cfg/kube-proxy.kubeconfig"
```
>> //改一处IP即可

### "2）创建kube-proxy systemd文件"

> [root@cloudsec3 cfg]# vi /usr/lib/systemd/system/kube-proxy.service
```
[Unit]
Description=Kubernetes Proxy
After=network.target
 
[Service]
EnvironmentFile=-/k8s/kubernetes/cfg/kube-proxy
ExecStart=/k8s/kubernetes/bin/kube-proxy $KUBE_PROXY_OPTS
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
```

### "3）启动服务 systemctl daemon-reload systemctl enable kube-proxy systemctl start kube-proxy"

```
systemctl daemon-reload 
systemctl enable kube-proxy 
systemctl start kube-proxy

[root@cloudsec3 cfg]# systemctl daemon-reload
[root@cloudsec3 cfg]# systemctl enable kube-proxy
Created symlink from /etc/systemd/system/multi-user.target.wants/kube-proxy.service to /usr/lib/systemd/system/kube-proxy.service.
[root@cloudsec3 cfg]# systemctl start kube-proxy
[root@cloudsec3 cfg]# systemctl status kube-proxy
● kube-proxy.service - Kubernetes Proxy
   Loaded: loaded (/usr/lib/systemd/system/kube-proxy.service; enabled; vendor preset: disabled)
   Active: active (running) since Tue 2019-03-05 21:22:38 CST; 26s ago
 Main PID: 11374 (kube-proxy)
   CGroup: /system.slice/kube-proxy.service
           ‣ 11374 /k8s/kubernetes/bin/kube-proxy --logtostderr=true --v=4 --hostname-override=9.186.102.71 --cluster-cidr=1...

Mar 05 21:22:56 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:22:56.298749   11374 config.go:141] Calling hand...date
Mar 05 21:22:56 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:22:56.300664   11374 config.go:141] Calling hand...date
Mar 05 21:22:58 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:22:58.309749   11374 config.go:141] Calling hand...date
Mar 05 21:22:58 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:22:58.310496   11374 config.go:141] Calling hand...date
Mar 05 21:23:00 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:23:00.317536   11374 config.go:141] Calling hand...date
Mar 05 21:23:00 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:23:00.321098   11374 config.go:141] Calling hand...date
Mar 05 21:23:02 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:23:02.327315   11374 config.go:141] Calling hand...date
Mar 05 21:23:02 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:23:02.332762   11374 config.go:141] Calling hand...date
Mar 05 21:23:04 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:23:04.338679   11374 config.go:141] Calling hand...date
Mar 05 21:23:04 cloudsec3.sl.cloud9.ibm.com kube-proxy[11374]: I0305 21:23:04.342155   11374 config.go:141] Calling hand...date
Hint: Some lines were ellipsized, use -l to show in full.
```

### "4）查看集群状态"

```
[root@cloudsec2 ssl]# kubectl get nodes
NAME           STATUS   ROLES    AGE   VERSION
9.186.102.71   Ready    <none>   10m   v1.13.1
```

### "5）同样操作部署node 10.2.8.34并认证csr，认证后会生成kubelet-client证书"

>> //这一部分其实主要就是在第二个普通节点（cloudsec4）上把docker、kubelet、kube-proxy（flannel除外，比较独立，后面再装）装起来。由于前面那部分就是在第一个普通节点（cloudsec3）上安装的过程，所以这部分基本一样————除了"7）将kubelet-bootstrap用户绑定到系统集群角色"这一步疑似可省以外————因此简略点。此外，这部分就不要在意#的数量了，几级标题什么的已经意义不大了，反正都被一对巨长的\`\`\` \`\`\`给包起来了。

--------------------------------------------------分隔线：开始--------------------------------------------------

```
# docker环境安装略，之前已装

yum install -y yum-utils device-mapper-persistent-data lvm2
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/docker-ce.repo
yum install -y docker-ce

# 1）安装二进制文件

wget https://dl.k8s.io/v1.13.1/kubernetes-node-linux-amd64.tar.gz
tar zxvf kubernetes-node-linux-amd64.tar.gz
cd kubernetes/node/bin/
cp kube-proxy kubelet kubectl /k8s/kubernetes/bin/

# 2）复制相关证书到node节点（切回master节点做）

cd /k8s/kubernetes/ssl/
scp *.pem 9.186.102.73:$PWD

[root@cloudsec2 ssl]# cd /k8s/kubernetes/ssl/
[root@cloudsec2 ssl]# scp *.pem 9.186.102.73:$PWD

[root@cloudsec4 bin]# cd /k8s/kubernetes/ssl/
[root@cloudsec4 ssl]# ll
total 24
-rw-------. 1 root root 1675 Mar  6 03:10 ca-key.pem
-rw-r--r--. 1 root root 1359 Mar  6 03:10 ca.pem
-rw-------. 1 root root 1675 Mar  6 03:10 kube-proxy-key.pem
-rw-r--r--. 1 root root 1403 Mar  6 03:10 kube-proxy.pem
-rw-------. 1 root root 1679 Mar  6 03:10 server-key.pem
-rw-r--r--. 1 root root 1627 Mar  6 03:10 server.pem

# 3）创建kubelet bootstrap kubeconfig文件 通过脚本实现

[root@cloudsec4 ssl]# vi /k8s/kubernetes/cfg/environment.sh
``
#!/bin/bash
#创建kubelet bootstrapping kubeconfig 
###BOOTSTRAP_TOKEN=f2c50331f07be89278acdaf341ff1ecc
###KUBE_APISERVER="https://10.2.8.44:6443"
BOOTSTRAP_TOKEN=a7be4d31d97e5e9731237f05d2bbd46a
KUBE_APISERVER="https://9.186.102.196:6443"
#设置集群参数
kubectl config set-cluster kubernetes \
  --certificate-authority=/k8s/kubernetes/ssl/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=bootstrap.kubeconfig
 
#设置客户端认证参数
kubectl config set-credentials kubelet-bootstrap \
  --token=${BOOTSTRAP_TOKEN} \
  --kubeconfig=bootstrap.kubeconfig
 
# 设置上下文参数
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kubelet-bootstrap \
  --kubeconfig=bootstrap.kubeconfig
 
# 设置默认上下文
kubectl config use-context default --kubeconfig=bootstrap.kubeconfig
 
#----------------------
 
# 创建kube-proxy kubeconfig文件
 
kubectl config set-cluster kubernetes \
  --certificate-authority=/k8s/kubernetes/ssl/ca.pem \
  --embed-certs=true \
  --server=${KUBE_APISERVER} \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config set-credentials kube-proxy \
  --client-certificate=/k8s/kubernetes/ssl/kube-proxy.pem \
  --client-key=/k8s/kubernetes/ssl/kube-proxy-key.pem \
  --embed-certs=true \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config set-context default \
  --cluster=kubernetes \
  --user=kube-proxy \
  --kubeconfig=kube-proxy.kubeconfig
 
kubectl config use-context default --kubeconfig=kube-proxy.kubeconfig
``

# 执行脚本

[root@cloudsec4 ssl]# cd /k8s/kubernetes/cfg/
[root@cloudsec4 cfg]# ll
total 4
-rw-r--r--. 1 root root 1512 Mar  6 03:17 environment.sh
[root@cloudsec4 cfg]# ln -s /k8s/kubernetes/bin/kubectl /usr/local/bin/kubectl
[root@cloudsec4 cfg]# sh environment.sh
Cluster "kubernetes" set.
User "kubelet-bootstrap" set.
Context "default" created.
Switched to context "default".
Cluster "kubernetes" set.
User "kube-proxy" set.
Context "default" created.
Switched to context "default".
[root@cloudsec4 cfg]# ll
total 16
-rw-------. 1 root root 2167 Mar  6 03:18 bootstrap.kubeconfig
-rw-r--r--. 1 root root 1512 Mar  6 03:17 environment.sh
-rw-------. 1 root root 6269 Mar  6 03:18 kube-proxy.kubeconfig

# 4）创建kubelet参数配置模板文件

[root@cloudsec4 cfg]# vi /k8s/kubernetes/cfg/kubelet.config
``
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
address: 9.186.102.73
port: 10250
readOnlyPort: 10255
cgroupDriver: cgroupfs
clusterDNS: ["10.254.0.10"]
clusterDomain: cluster.local.
failSwapOn: false
authentication:
  anonymous:
    enabled: true
``

# 5）创建kubelet配置文件

[root@cloudsec4 cfg]# vi /k8s/kubernetes/cfg/kubelet
``
KUBELET_OPTS="--logtostderr=true \
--v=4 \
--hostname-override=9.186.102.73 \
--kubeconfig=/k8s/kubernetes/cfg/kubelet.kubeconfig \
--bootstrap-kubeconfig=/k8s/kubernetes/cfg/bootstrap.kubeconfig \
--config=/k8s/kubernetes/cfg/kubelet.config \
--cert-dir=/k8s/kubernetes/ssl \
--pod-infra-container-image=registry.cn-hangzhou.aliyuncs.com/google-containers/pause-amd64:3.0"
``

# 6）创建kubelet systemd文件

[root@cloudsec4 cfg]# vi /usr/lib/systemd/system/kubelet.service
``
[Unit]
Description=Kubernetes Kubelet
After=docker.service
Requires=docker.service
 
[Service]
EnvironmentFile=/k8s/kubernetes/cfg/kubelet
ExecStart=/k8s/kubernetes/bin/kubelet $KUBELET_OPTS
Restart=on-failure
KillMode=process
 
[Install]
WantedBy=multi-user.target
``

# 7）将kubelet-bootstrap用户绑定到系统集群角色
//不用做了似乎

# 8）启动服务 systemctl daemon-reload systemctl enable kubelet systemctl start kubelet

[root@cloudsec4 cfg]# systemctl daemon-reload
[root@cloudsec4 cfg]# systemctl enable kubelet
Created symlink from /etc/systemd/system/multi-user.target.wants/kubelet.service to /usr/lib/systemd/system/kubelet.service.
[root@cloudsec4 cfg]# systemctl start kubelet
[root@cloudsec4 cfg]# systemctl status kubelet
● kubelet.service - Kubernetes Kubelet
   Loaded: loaded (/usr/lib/systemd/system/kubelet.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2019-03-06 03:58:28 CST; 13s ago
 Main PID: 8526 (kubelet)
    Tasks: 10
   Memory: 17.3M
   CGroup: /system.slice/kubelet.service
           └─8526 /k8s/kubernetes/bin/kubelet --logtostderr=true --v=4 --hostname-override=9.186.102.73 --kubeconfig=/k8s/kubernetes/cfg/kubelet.kubeco...

Mar 06 03:58:28 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:28.221560    8526 feature_gate.go:206] feature gates: &{map[]}
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.368360    8526 server.go:825] Using self-signed cert (/k8s/kubernetes/...et.key)
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.391808    8526 mount_linux.go:179] Detected OS with systemd
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.391879    8526 server.go:407] Version: v1.13.1
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.391982    8526 feature_gate.go:206] feature gates: &{map[]}
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.392046    8526 feature_gate.go:206] feature gates: &{map[]}
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.392150    8526 plugins.go:103] No cloud provider specified.
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.392167    8526 server.go:523] No cloud provider specified: "" from the...ile: ""
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.392199    8526 bootstrap.go:65] Using bootstrap kubeconfig to generate...ig file
Mar 06 03:58:29 cloudsec4.sl.cloud9.ibm.com kubelet[8526]: I0306 03:58:29.394356    8526 bootstrap.go:96] No valid private key and/or certificat...new one
Hint: Some lines were ellipsized, use -l to show in full.

# 9）Master接受kubelet CSR请求 可以手动或自动 approve CSR 请求。推荐使用自动的方式，因为从 v1.8 版本开始，
可以自动轮转approve csr 后生成的证书，如下是手动 approve CSR请求操作方法 查看CSR列表

//此步骤需回到master

[root@cloudsec2 ssl]# kubectl get nodes
NAME           STATUS   ROLES    AGE     VERSION
9.186.102.71   Ready    <none>   6h47m   v1.13.1
[root@cloudsec2 ssl]# kubectl get csr
NAME                                                   AGE     REQUESTOR           CONDITION
node-csr-D0gwFOV6nkjuQZ6xxhECBG9sAqyDtJmEk41I2bJ99Zo   5m37s   kubelet-bootstrap   Pending
[root@cloudsec2 ssl]# kubectl certificate approve node-csr-D0gwFOV6nkjuQZ6xxhECBG9sAqyDtJmEk41I2bJ99Zo
certificatesigningrequest.certificates.k8s.io/node-csr-D0gwFOV6nkjuQZ6xxhECBG9sAqyDtJmEk41I2bJ99Zo approved
[root@cloudsec2 ssl]# kubectl get csr
NAME                                                   AGE     REQUESTOR           CONDITION
node-csr-D0gwFOV6nkjuQZ6xxhECBG9sAqyDtJmEk41I2bJ99Zo   6m56s   kubelet-bootstrap   Approved,Issued
[root@cloudsec2 ssl]# kubectl get nodes
NAME           STATUS   ROLES    AGE     VERSION
9.186.102.71   Ready    <none>   6h51m   v1.13.1
9.186.102.73   Ready    <none>   32s     v1.13.1

### 【*】关于过程中生成的证书，又给忘了，所以只有一个大略的点：

- 1.用history对比了下时间，最晚的那一个证书和一个软链接是主节点执行 kubectl certificate approve 同意证书时候产生的（也不排除是kubectl get csr 或者 kubectl get nodes，但是可能性很小）。
- 2.kubelet.crt和kubelet.key还是没弄彻底确定谁产生的（但是从时间距离就几分钟来看，肯定就是前面涉及kubelet那几步），回头总结的时候或者下次再看吧。

[root@cloudsec4 ssl]# ls -lt
total 36
lrwxrwxrwx. 1 root root   58 Mar  6 04:05 kubelet-client-current.pem -> /k8s/kubernetes/ssl/kubelet-client-2019-03-06-04-05-00.pem
-rw-------. 1 root root 1273 Mar  6 04:05 kubelet-client-2019-03-06-04-05-00.pem
-rw-r--r--. 1 root root 2181 Mar  6 03:58 kubelet.crt
-rw-------. 1 root root 1675 Mar  6 03:58 kubelet.key
-rw-r--r--. 1 root root 1627 Mar  6 03:10 server.pem
-rw-------. 1 root root 1679 Mar  6 03:10 server-key.pem
-rw-r--r--. 1 root root 1403 Mar  6 03:10 kube-proxy.pem
-rw-------. 1 root root 1675 Mar  6 03:10 kube-proxy-key.pem
-rw-r--r--. 1 root root 1359 Mar  6 03:10 ca.pem
-rw-------. 1 root root 1675 Mar  6 03:10 ca-key.pem

# 5.3部署kube-proxy组件

# 1）创建 kube-proxy 配置文件

[root@cloudsec4 cfg]# vi /k8s/kubernetes/cfg/kube-proxy
``
KUBE_PROXY_OPTS="--logtostderr=true \
--v=4 \
--hostname-override=9.186.102.73 \
--cluster-cidr=10.254.0.0/16 \
--kubeconfig=/k8s/kubernetes/cfg/kube-proxy.kubeconfig"
``

# 2）创建kube-proxy systemd文件

[root@cloudsec4 cfg]# vi /usr/lib/systemd/system/kube-proxy.service
``
[Unit]
Description=Kubernetes Proxy
After=network.target
 
[Service]
EnvironmentFile=-/k8s/kubernetes/cfg/kube-proxy
ExecStart=/k8s/kubernetes/bin/kube-proxy $KUBE_PROXY_OPTS
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
``

# 3）启动服务 systemctl daemon-reload systemctl enable kube-proxy systemctl start kube-proxy

[root@cloudsec4 cfg]# systemctl daemon-reload
[root@cloudsec4 cfg]# systemctl enable kube-proxy
Created symlink from /etc/systemd/system/multi-user.target.wants/kube-proxy.service to /usr/lib/systemd/system/kube-proxy.service.
[root@cloudsec4 cfg]# systemctl start kube-proxy
[root@cloudsec4 cfg]# systemctl status kube-proxy
● kube-proxy.service - Kubernetes Proxy
   Loaded: loaded (/usr/lib/systemd/system/kube-proxy.service; enabled; vendor preset: disabled)
   Active: active (running) since Wed 2019-03-06 04:35:08 CST; 37s ago
 Main PID: 22297 (kube-proxy)
    Tasks: 0
   Memory: 11.0M
   CGroup: /system.slice/kube-proxy.service
           ‣ 22297 /k8s/kubernetes/bin/kube-proxy --logtostderr=true --v=4 --hostname-override=9.186.102.73 --cluster-cidr=10.254.0.0/16 --kubeconfig=/...

Mar 06 04:35:38 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:38.800682   22297 iptables.go:327] running iptables-save [-t nat]
Mar 06 04:35:38 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:38.803424   22297 iptables.go:391] running iptables-restore [-w 5 --n...unters]
Mar 06 04:35:38 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:38.806806   22297 proxier.go:641] syncProxyRules took 30.693661ms
Mar 06 04:35:38 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:38.806869   22297 bounded_frequency_runner.go:221] sync-runner: ran, ... in 30s
Mar 06 04:35:39 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:39.467083   22297 config.go:141] Calling handler.OnEndpointsUpdate
Mar 06 04:35:39 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:39.469481   22297 config.go:141] Calling handler.OnEndpointsUpdate
Mar 06 04:35:41 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:41.477490   22297 config.go:141] Calling handler.OnEndpointsUpdate
Mar 06 04:35:41 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:41.478382   22297 config.go:141] Calling handler.OnEndpointsUpdate
Mar 06 04:35:43 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:43.486012   22297 config.go:141] Calling handler.OnEndpointsUpdate
Mar 06 04:35:43 cloudsec4.sl.cloud9.ibm.com kube-proxy[22297]: I0306 04:35:43.492396   22297 config.go:141] Calling handler.OnEndpointsUpdate
Hint: Some lines were ellipsized, use -l to show in full.

# 4）查看集群状态

[root@cloudsec2 ssl]# kubectl get nodes
NAME           STATUS   ROLES    AGE     VERSION
9.186.102.71   Ready    <none>   7h23m   v1.13.1
9.186.102.73   Ready    <none>   32m     v1.13.1
```

--------------------------------------------------分隔线：结束--------------------------------------------------

>> //接上（两个分隔线之间的内容之前）

```
//两个node上不行，这问题这个教程里没涉及（教程里查这些用master节点），回来自己研究下。

[root@cloudsec4 ssl]# kubectl describe nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?

[root@cloudsec3 ssl]# kubectl get nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?
[root@cloudsec3 ssl]# kubectl describe nodes
The connection to the server localhost:8080 was refused - did you specify the right host or port?

//换到master上就可以查了，查出来只有两个node节点的信息，没有mastser的信息，不知道算不算正常。

[root@cloudsec2 ssl]# kubectl describe nodes
Name:               9.186.102.71
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/hostname=9.186.102.71
Annotations:        node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Tue, 05 Mar 2019 21:13:46 -0600
Taints:             <none>
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Wed, 06 Mar 2019 04:39:13 -0600   Tue, 05 Mar 2019 21:13:46 -0600   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Wed, 06 Mar 2019 04:39:13 -0600   Tue, 05 Mar 2019 21:13:46 -0600   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Wed, 06 Mar 2019 04:39:13 -0600   Tue, 05 Mar 2019 21:13:46 -0600   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Wed, 06 Mar 2019 04:39:13 -0600   Tue, 05 Mar 2019 21:13:56 -0600   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  9.186.102.71
  Hostname:    9.186.102.71
Capacity:
 cpu:                4
 ephemeral-storage:  102822192Ki
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             16261092Ki
 pods:               110
Allocatable:
 cpu:                4
 ephemeral-storage:  94760931991
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             16158692Ki
 pods:               110
System Info:
 Machine ID:                 fce9d636fe02427aac7b94f9c5c6b3ff
 System UUID:                0487F6F6-2102-80E2-A14B-15B4B486A0E7
 Boot ID:                    99084cd2-c8e1-4fc6-8457-57a4d1fc0c06
 Kernel Version:             3.10.0-957.1.3.el7.x86_64
 OS Image:                   CentOS Linux 7 (Core)
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://18.9.3
 Kubelet Version:            v1.13.1
 Kube-Proxy Version:         v1.13.1
Non-terminated Pods:         (0 in total)
  Namespace                  Name    CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                  ----    ------------  ----------  ---------------  -------------  ---
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests  Limits
  --------           --------  ------
  cpu                0 (0%)    0 (0%)
  memory             0 (0%)    0 (0%)
  ephemeral-storage  0 (0%)    0 (0%)
Events:              <none>


Name:               9.186.102.73
Roles:              <none>
Labels:             beta.kubernetes.io/arch=amd64
                    beta.kubernetes.io/os=linux
                    kubernetes.io/hostname=9.186.102.73
Annotations:        node.alpha.kubernetes.io/ttl: 0
                    volumes.kubernetes.io/controller-managed-attach-detach: true
CreationTimestamp:  Wed, 06 Mar 2019 04:05:00 -0600
Taints:             <none>
Unschedulable:      false
Conditions:
  Type             Status  LastHeartbeatTime                 LastTransitionTime                Reason                       Message
  ----             ------  -----------------                 ------------------                ------                       -------
  MemoryPressure   False   Wed, 06 Mar 2019 04:39:13 -0600   Wed, 06 Mar 2019 04:05:00 -0600   KubeletHasSufficientMemory   kubelet has sufficient memory available
  DiskPressure     False   Wed, 06 Mar 2019 04:39:13 -0600   Wed, 06 Mar 2019 04:05:00 -0600   KubeletHasNoDiskPressure     kubelet has no disk pressure
  PIDPressure      False   Wed, 06 Mar 2019 04:39:13 -0600   Wed, 06 Mar 2019 04:05:00 -0600   KubeletHasSufficientPID      kubelet has sufficient PID available
  Ready            True    Wed, 06 Mar 2019 04:39:13 -0600   Wed, 06 Mar 2019 04:05:10 -0600   KubeletReady                 kubelet is posting ready status
Addresses:
  InternalIP:  9.186.102.73
  Hostname:    9.186.102.73
Capacity:
 cpu:                4
 ephemeral-storage:  102822192Ki
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             16261092Ki
 pods:               110
Allocatable:
 cpu:                4
 ephemeral-storage:  94760931991
 hugepages-1Gi:      0
 hugepages-2Mi:      0
 memory:             16158692Ki
 pods:               110
System Info:
 Machine ID:                 fce9d636fe02427aac7b94f9c5c6b3ff
 System UUID:                B1CBF635-8EBB-6E74-1CD0-A8516AE7AB97
 Boot ID:                    189e0f8a-4e66-4511-87a9-268debb22d29
 Kernel Version:             3.10.0-957.1.3.el7.x86_64
 OS Image:                   CentOS Linux 7 (Core)
 Operating System:           linux
 Architecture:               amd64
 Container Runtime Version:  docker://18.9.3
 Kubelet Version:            v1.13.1
 Kube-Proxy Version:         v1.13.1
Non-terminated Pods:         (0 in total)
  Namespace                  Name    CPU Requests  CPU Limits  Memory Requests  Memory Limits  AGE
  ---------                  ----    ------------  ----------  ---------------  -------------  ---
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests  Limits
  --------           --------  ------
  cpu                0 (0%)    0 (0%)
  memory             0 (0%)    0 (0%)
  ephemeral-storage  0 (0%)    0 (0%)
Events:
  Type    Reason                   Age   From                      Message
  ----    ------                   ----  ----                      -------
  Normal  Starting                 34m   kubelet, 9.186.102.73     Starting kubelet.
  Normal  NodeHasSufficientMemory  34m   kubelet, 9.186.102.73     Node 9.186.102.73 status is now: NodeHasSufficientMemory
  Normal  NodeHasNoDiskPressure    34m   kubelet, 9.186.102.73     Node 9.186.102.73 status is now: NodeHasNoDiskPressure
  Normal  NodeHasSufficientPID     34m   kubelet, 9.186.102.73     Node 9.186.102.73 status is now: NodeHasSufficientPID
  Normal  NodeAllocatableEnforced  34m   kubelet, 9.186.102.73     Updated Node Allocatable limit across pods
  Normal  NodeReady                34m   kubelet, 9.186.102.73     Node 9.186.102.73 status is now: NodeReady
  Normal  Starting                 4m8s  kube-proxy, 9.186.102.73  Starting kube-proxy.
```

# "六 Flanneld网络部署"

>> //之前先查下IP，这样更容易明白flanneld改变了什么。注意此时`docker0`的IP是`172.17.0.1`。
```
[root@cloudsec3 ~]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 06:32:ad:6c:c2:b4 brd ff:ff:ff:ff:ff:ff
    inet 10.174.93.71/24 brd 10.174.93.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet 9.186.102.71/24 brd 9.186.102.255 scope global eth0:0
       valid_lft forever preferred_lft forever
    inet6 fe80::432:adff:fe6c:c2b4/64 scope link
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:98:dd:ca:2c brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:98ff:fedd:ca2c/64 scope link
       valid_lft forever preferred_lft forever
```

>> //因为flannel的作用是pod间通信，所以有的文章里提到过可以通过容器之间ping来说明，但是目前没发现什么比较好的例子。
```
//随手在master节点试了下：

//起一个sh容器：
[root@cloudsec2 ~]# docker run -dit busybox sh
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
697743189b6d: Pull complete
Digest: sha256:061ca9704a714ee3e8b80523ec720c64f6209ad3f97c0ff7cb9ec7d19f15149f
Status: Downloaded newer image for busybox:latest
f29a73a855dbd4024695fd5b59e139a2f162354d8c1cc1623a64aeae6e6d5591

//因为带了-d参数，所以还得再起一下，同时查看下网址：
[root@cloudsec2 ~]# docker exec -it f29a73a855dbd40246 /bin/sh
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever

//再起一个名为mysh2的sh容器，在该容器里ping第一个容器，ping得通
[root@cloudsec2 ~]# docker run --name mysh2 -it busybox sh
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
6: eth0@if7: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue
    link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.3/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
/ # ping 127.17.0.2
PING 127.17.0.2 (127.17.0.2): 56 data bytes
64 bytes from 127.17.0.2: seq=0 ttl=64 time=0.085 ms
64 bytes from 127.17.0.2: seq=1 ttl=64 time=0.061 ms
64 bytes from 127.17.0.2: seq=2 ttl=64 time=0.063 ms
64 bytes from 127.17.0.2: seq=3 ttl=64 time=0.114 ms
64 bytes from 127.17.0.2: seq=4 ttl=64 time=0.100 ms
^C
--- 127.17.0.2 ping statistics ---
5 packets transmitted, 5 packets received, 0% packet loss
round-trip min/avg/max = 0.061/0.084/0.114 ms
```

>> //实际上还发现，docker容器内部的IP也变了
```
//这次是在要安装flannel的节点（也就是cloudsec3）上进行的了：

//安装flannel之前先起了个容器看了看IP:
[root@cloudsec3 ~]# docker run -it busybox sh
Unable to find image 'busybox:latest' locally
latest: Pulling from library/busybox
697743189b6d: Pull complete
Digest: sha256:061ca9704a714ee3e8b80523ec720c64f6209ad3f97c0ff7cb9ec7d19f15149f
Status: Downloaded newer image for busybox:latest
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
4: eth0@if5: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue
    link/ether 02:42:ac:11:00:02 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever

//安装flannel之后重新启动这个容器看了下，IP也变了。
[root@cloudsec3 k8s]# docker start -i 3f98c2459be4
/ # ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
7: eth0@if8: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1450 qdisc noqueue
    link/ether 02:42:0a:fe:4c:02 brd ff:ff:ff:ff:ff:ff
    inet 10.254.76.2/24 brd 10.254.76.255 scope global eth0
       valid_lft forever preferred_lft forever
```

## "6.1 etcd注册网段"

```
[root@cloudsec3 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" set /k8s/network/config '{ "Network": "10.254.0.0/16", "Backend": {"Type": "vxlan"}}'
{ "Network": "10.254.0.0/16", "Backend": {"Type": "vxlan"}}
[root@cloudsec3 ~]#
[root@cloudsec3 ~]# /k8s/etcd/bin/etcdctl --ca-file=/k8s/etcd/ssl/ca.pem --cert-file=/k8s/etcd/ssl/server.pem --key-file=/k8s/etcd/ssl/server-key.pem --endpoints="https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379" get /k8s/network/config
{ "Network": "10.254.0.0/16", "Backend": {"Type": "vxlan"}}
```

## "6.2 flannel安装"

### "1）解压安装"

```
tar -xvf flannel-v0.10.0-linux-amd64.tar.gz
mv flanneld mk-docker-opts.sh /k8s/kubernetes/bin/
```

### "2）配置flanneld"

> vi /k8s/kubernetes/cfg/flanneld
```
FLANNEL_OPTIONS="--etcd-endpoints=https://9.186.102.196:2379,https://9.186.102.71:2379,https://9.186.102.73:2379 -etcd-cafile=/k8s/etcd/ssl/ca.pem -etcd-certfile=/k8s/etcd/ssl/server.pem -etcd-keyfile=/k8s/etcd/ssl/server-key.pem -etcd-prefix=/k8s/network"
```
>> //修改endpoints里的三个IP

#### "创建flanneld systemd文件"

> vi /usr/lib/systemd/system/flanneld.service
```
[Unit]
Description=Flanneld overlay address etcd agent
After=network-online.target network.target
Before=docker.service
 
[Service]
Type=notify
EnvironmentFile=/k8s/kubernetes/cfg/flanneld
ExecStart=/k8s/kubernetes/bin/flanneld --ip-masq $FLANNEL_OPTIONS
ExecStartPost=/k8s/kubernetes/bin/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/subnet.env
Restart=on-failure
 
[Install]
WantedBy=multi-user.target
```

### "3）配置Docker启动指定子网 修改EnvironmentFile=/run/flannel/subnet.env，ExecStart=/usr/bin/dockerd $DOCKER_NETWORK_OPTIONS即可"

> vi /usr/lib/systemd/system/docker.service
```
[Unit]
Description=Docker Application Container Engine
Documentation=https://docs.docker.com
After=network-online.target firewalld.service
Wants=network-online.target
 
[Service]
Type=notify
EnvironmentFile=/run/flannel/subnet.env
ExecStart=/usr/bin/dockerd $DOCKER_NETWORK_OPTIONS
ExecReload=/bin/kill -s HUP $MAINPID
LimitNOFILE=infinity
LimitNPROC=infinity
LimitCORE=infinity
TimeoutStartSec=0
Delegate=yes
KillMode=process
Restart=on-failure
StartLimitBurst=3
StartLimitInterval=60s
 
[Install]
WantedBy=multi-user.target
```

### "4）启动服务 注意启动flannel前要关闭docker及相关的kubelet这样flannel才会覆盖docker0网桥"

```
systemctl daemon-reload
systemctl stop docker
systemctl start flanneld
systemctl enable flanneld
systemctl start docker
systemctl restart kubelet
systemctl restart kube-proxy
```

```
[root@cloudsec3 cfg]# systemctl daemon-reload
[root@cloudsec3 cfg]# systemctl stop docker
[root@cloudsec3 cfg]# systemctl start flanneld
[root@cloudsec3 cfg]# systemctl enable flanneld
Created symlink from /etc/systemd/system/multi-user.target.wants/flanneld.service to /usr/lib/systemd/system/flanneld.service.
[root@cloudsec3 cfg]# systemctl start docker
[root@cloudsec3 cfg]# systemctl restart kubelet
[root@cloudsec3 cfg]# systemctl restart kube-proxy
```

### "5）验证服务"

```
[root@cloudsec3 cfg]# cat /run/flannel/subnet.env
DOCKER_OPT_BIP="--bip=10.254.76.1/24"
DOCKER_OPT_IPMASQ="--ip-masq=false"
DOCKER_OPT_MTU="--mtu=1450"
DOCKER_NETWORK_OPTIONS=" --bip=10.254.76.1/24 --ip-masq=false --mtu=1450"
```

```
[root@cloudsec3 cfg]# ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 06:32:ad:6c:c2:b4 brd ff:ff:ff:ff:ff:ff
    inet 10.174.93.71/24 brd 10.174.93.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet 9.186.102.71/24 brd 9.186.102.255 scope global eth0:0
       valid_lft forever preferred_lft forever
    inet6 fe80::432:adff:fe6c:c2b4/64 scope link
       valid_lft forever preferred_lft forever
3: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default
    link/ether 02:42:98:dd:ca:2c brd ff:ff:ff:ff:ff:ff
    inet 10.254.76.1/24 brd 10.254.76.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:98ff:fedd:ca2c/64 scope link
       valid_lft forever preferred_lft forever
6: flannel.1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1450 qdisc noqueue state UNKNOWN group default
    link/ether 1a:0a:91:ca:fd:0c brd ff:ff:ff:ff:ff:ff
    inet 10.254.76.0/32 scope global flannel.1
       valid_lft forever preferred_lft forever
    inet6 fe80::180a:91ff:feca:fd0c/64 scope link
       valid_lft forever preferred_lft forever
```

>> //注意，此时不但多了`flannel.1`，而且`docker0`的IP也变了，和flannel处于一个网段了。

# 另外一个节点的flannel和这个节点是一样的，省略。

>> //实际上配完一个节点的flannel后另一个到现在还没配。一是因为步骤上一模一样，所以也无需再记录了；二是还没试出来到底区别在哪，作用是什么。所以可能后续再试试，总结下补上；也可能其实没啥东西，这个文档就完全结束。

