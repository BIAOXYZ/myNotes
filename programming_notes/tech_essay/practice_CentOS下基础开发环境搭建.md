
# Docker and Docker Compose

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
未执行，应该是现在新版默认安装完就启动
```

- 建立 docker 用户组
```
sudo groupadd docker

// sudo usermod -aG docker $USER
sudo usermod -aG docker test2  
```

- 二进制方式安装docker-compose
```
//sudo curl -L https://github.com/docker/compose/releases/download/1.17.1/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
//sudo chmod +x /usr/local/bin/docker-compose

sudo curl -L https://github.com/docker/compose/releases/download/1.23.0-rc3/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```
