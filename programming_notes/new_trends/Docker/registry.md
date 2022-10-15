
# Docker Registry (后来改名叫`Distribution`)

https://github.com/docker/distribution/blob/master/README.md
- `For these use cases and others, deploying your own registry instance may be the better choice.` https://github.com/docker/docker.github.io/blob/master/registry/deploying.md
- `If you are contributing code, see the instructions for building a development environment.` https://github.com/docker/distribution/blob/master/BUILDING.md

配置私有仓库(使用registry镜像搭建一个私有仓库) https://www.cnblogs.com/wade-luffy/p/6590849.html
- > 此外，Registry默认的存储位置为/var/lib/registry，可以通过-v参数来映射本地的路径到容器内。

# (Uber) Kraken

P2P Docker registry capable of distributing TBs of data in seconds https://github.com/uber/kraken

# (Alibaba) Dragonfly

Dragonfly is an intelligent P2P based image and file distribution system. https://d7y.io/ || https://github.com/dragonflyoss/Dragonfly

# JFrog Container Registry

Announcing JFrog Container Registry https://jfrog.com/blog/announcing-jfrog-container-registry/

JFrog Container Registry https://jfrog.com/container-registry/

Overview https://www.jfrog.com/confluence/display/JCR/Overview

# Harbor

When to support P2P in image distribution? #3769 https://github.com/goharbor/harbor/issues/3769

## harbor源码

Harbor 源码分析之API（四） https://blog.csdn.net/u010278923/article/details/72514760

Harbor中的用户密码加密机制探究 http://phantom0301.cc/2017/02/08/harborpass/

#harbor https://www.qikqiak.com/tags/harbor/
- Harbor 源码浅析 https://www.qikqiak.com/post/harbor-code-analysis/

## harbor其他

A CLI tool for the Docker Registry Harbor https://github.com/int32bit/python-harborclient

Containerd 对接私有镜像仓库 Harbor https://mp.weixin.qq.com/s/ZqLu97S6VluRc1Mu0jL1Uw
