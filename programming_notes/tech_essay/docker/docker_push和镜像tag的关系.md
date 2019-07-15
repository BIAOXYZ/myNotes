

# 0. docker push到远端仓库时，本地tag情况的影响

**注：dockerhub账号和quay.io账号均已在本地登陆！**

```sh
root@myopenshift:tmp$ docker images
REPOSITORY                                                      TAG                 IMAGE ID            CREATED             SIZE
scaler-operator                                                 v1                  dbee5320fdfa        About an hour ago   610 MB
biaoxyz/scaler-operator                                         v1                  dbee5320fdfa        About an hour ago   610 MB
docker.io/biaoxyz/scaler-operator                               v1                  dbee5320fdfa        About an hour ago   610 MB
quay.io/biaoxyz/scaler-operator                                 v1                  dbee5320fdfa        About an hour ago   610 MB
...
...

# 不妨把上面四个镜像分别称为：
# ① “原始镜像”： scaler-operator:v1
# ② “带用户名镜像”： biaoxyz/scaler-operator:v1
# ③ “带docker.io的用户名镜像”： docker.io/biaoxyz/scaler-operator:v1
# ④ “带quay.io的用户名镜像”： quay.io/biaoxyz/scaler-operator:v1

# 这次主要是趁机试试各种推送的情况，发现了一个有趣的结论：尽管一般情况下省略docker.io就表示是在docker官方的镜像
# 仓库dockerhub进行操作。但是实际上还是有些不一样的：
#  - 如果本地镜像的tag没有带docker.io前缀，那么可以直接推“带用户名镜像”（②）；但是不能直接推“带docker.io的用户名镜像”（③）。
#  - 再新做一个tag里带docker.io前缀的就可以推“带docker.io的用户名镜像”（③）了；但是这两个推送的仓库是同一个。

# 所以最终结论是：如果往docker官方镜像仓库推，根据带不带docker.io前缀需要不同的本地镜像，但最终推送的仓库是一致的；如果往别的镜像仓库（如quay.io）推，必须带没啥可说的。


// “原始镜像”的产生，自己build出来的，没得说。
root@myopenshift:scaler-operator$ operator-sdk build scaler-operator:v1

// 从原始镜像通过tag的方式，做出“带用户名的镜像”。
root@myopenshift:scaler-operator$ docker tag scaler-operator:v1 biaoxyz/scaler-operator:v1

// 尝试推“带docker.io的用户名镜像”，发现不行，提示本地没有带这个tag的镜像。
//（注意：也就是说 “docker.io/” 被当成了tag的一部分）
root@myopenshift:scaler-operator$ docker push docker.io/biaoxyz/scaler-operator:v1
The push refers to a repository [docker.io/biaoxyz/scaler-operator]
An image does not exist locally with the tag: docker.io/biaoxyz/scaler-operator

// 推送“带用户名镜像”成功。推送的远端目标仓库为：“docker.io/biaoxyz/scaler-operator”。
root@myopenshift:scaler-operator$ docker push biaoxyz/scaler-operator:v1
The push refers to a repository [docker.io/biaoxyz/scaler-operator]
df87493a9d6d: Pushed
59090df7d243: Pushed
cf7287d2534f: Pushed
444c8cb7c2eb: Pushed
a3fc877dfcaa: Pushed
f5f9c982616a: Pushed
feb8f7b63c08: Pushed
47ca57f46f58: Pushed
13d859cf0192: Pushed
80817170de8e: Pushed
dd09b1c319a6: Pushed
f7b5949a5f66: Pushed
4616d642ce19: Pushed
be81e9b31e54: Pushed
63d9d56008cb: Pushed
56a62cb9d96c: Pushed
3f9dc45a1d02: Pushed
dac20332f7b5: Pushed
24f8e5ff1817: Pushed
1bdae1c8263a: Pushed
bc08b53be3d4: Pushed
071d8bd76517: Mounted from openshift/origin-docker-registry
v1: digest: sha256:81e056bbb515225f27509014dace8b6b56948e411ca995ab1ee4d527a5ceca64 size: 4916

// 往quay.io这个推送失败在意料之中，因为本地还没有tag为 “quay.io/biaoxyz/scaler-operator” 的镜像。
root@myopenshift:scaler-operator$ docker push quay.io/biaoxyz/scaler-operator:v1
The push refers to a repository [quay.io/biaoxyz/scaler-operator]
An image does not exist locally with the tag: quay.io/biaoxyz/scaler-operator

// 这个推送失败也算是预料之中，毕竟连用户名都不在tag里给，往哪给你推去？
root@myopenshift:scaler-operator$ docker push scaler-operator:v1
Error response from daemon: You cannot push a "root" repository. Please rename your repository to docker.io/<user>/<repo> (ex:
docker.io/biaoxyz/scaler-operator)

// 连打两个新tag方便后面试，也就说把第三个和第四个镜像搞出来了。
root@myopenshift:scaler-operator$ docker tag scaler-operator:v1 quay.io/biaoxyz/scaler-operator:v1
root@myopenshift:scaler-operator$ docker tag scaler-operator:v1 docker.io/biaoxyz/scaler-operator:v1
root@myopenshift:scaler-operator$

// 这次往quay.io推送成功在意料之中。
root@myopenshift:scaler-operator$ docker push quay.io/biaoxyz/scaler-operator:v1
The push refers to a repository [quay.io/biaoxyz/scaler-operator]
df87493a9d6d: Pushed
59090df7d243: Pushed
cf7287d2534f: Mounted from operator-framework/ansible-operator
444c8cb7c2eb: Mounted from operator-framework/ansible-operator
a3fc877dfcaa: Mounted from operator-framework/ansible-operator
f5f9c982616a: Mounted from operator-framework/ansible-operator
feb8f7b63c08: Mounted from operator-framework/ansible-operator
47ca57f46f58: Mounted from operator-framework/ansible-operator
13d859cf0192: Mounted from operator-framework/ansible-operator
80817170de8e: Mounted from operator-framework/ansible-operator
dd09b1c319a6: Mounted from operator-framework/ansible-operator
f7b5949a5f66: Mounted from operator-framework/ansible-operator
4616d642ce19: Mounted from operator-framework/ansible-operator
be81e9b31e54: Mounted from operator-framework/ansible-operator
63d9d56008cb: Mounted from operator-framework/ansible-operator
56a62cb9d96c: Mounted from operator-framework/ansible-operator
3f9dc45a1d02: Mounted from operator-framework/ansible-operator
dac20332f7b5: Mounted from operator-framework/ansible-operator
24f8e5ff1817: Mounted from operator-framework/ansible-operator
1bdae1c8263a: Mounted from operator-framework/ansible-operator
bc08b53be3d4: Mounted from operator-framework/ansible-operator
071d8bd76517: Pushed
v1: digest: sha256:2621ac276b60de680d9d8490bdd1392403ac01e27cae306393d5301309bb2e88 size: 20297

// 意料之中的情况：这次推送能成功————毕竟本地有tag为 “docker.io/biaoxyz/scaler-operator” 的镜像了。
// 意料之外的情况：我本来以为会推送到类似 “docker.io/docker.io/biaoxyz/scaler-operator” 的仓库，结果发现和之前是同一个仓库，即 “docker.io/biaoxyz/scaler-operator”。
root@myopenshift:scaler-operator$ docker push docker.io/biaoxyz/scaler-operator:v1
The push refers to a repository [docker.io/biaoxyz/scaler-operator]
df87493a9d6d: Layer already exists
59090df7d243: Layer already exists
cf7287d2534f: Layer already exists
444c8cb7c2eb: Layer already exists
a3fc877dfcaa: Layer already exists
f5f9c982616a: Layer already exists
feb8f7b63c08: Layer already exists
47ca57f46f58: Layer already exists
13d859cf0192: Layer already exists
80817170de8e: Layer already exists
dd09b1c319a6: Layer already exists
f7b5949a5f66: Layer already exists
4616d642ce19: Layer already exists
be81e9b31e54: Layer already exists
63d9d56008cb: Layer already exists
56a62cb9d96c: Layer already exists
3f9dc45a1d02: Layer already exists
dac20332f7b5: Layer already exists
24f8e5ff1817: Layer already exists
1bdae1c8263a: Layer already exists
bc08b53be3d4: Layer already exists
071d8bd76517: Layer already exists
v1: digest: sha256:81e056bbb515225f27509014dace8b6b56948e411ca995ab1ee4d527a5ceca64 size: 4916
```

# 1. 这部分是之前使用过的，推送镜像到本地仓库的过程。

## 1.1 首先要下载本地做仓库用的`registry`镜像并运行：

> docker pull docker.io/registry && docker run -d -p 5000:5000 --name=registry --restart=always --privileged=true --log-driver=none -v /home/data/registrydata:/tmp/registry registry
>> or simplely: docker run -d -p 5000:5000 --restart=always --name registry registry

## 1.2 然后把本地已有的镜像打上`相应的tag`并推送到本地仓库：
> docker tag quay.io/example/app-operator:latest 127.0.0.1:5000/quay.io/example/app-operator:latest && docker push 127.0.0.1:5000/quay.io/example/app-operator

# 2. 最后的尝试

## 2.1

**注**：实际上就是上面那句误导了我，让我以为可以存在形如`docker.io/docker.io/biaoxyz/scaler-operator`的tag————**实际上确实可以打出来这样的tag，但是最终是推不上去的**。下面展示了整个过程：
```
root@myopenshift:tmp$ docker tag scaler-operator:v1 docker.io/docker.io/scaler-operator:v1
root@myopenshift:tmp$ docker images
REPOSITORY                                                      TAG                 IMAGE ID            CREATED             SIZE
biaoxyz/scaler-operator                                         v1                  dbee5320fdfa        2 hours ago         610 MB
docker.io/biaoxyz/scaler-operator                               v1                  dbee5320fdfa        2 hours ago         610 MB
docker.io/docker.io/scaler-operator                             v1                  dbee5320fdfa        2 hours ago         610 MB
quay.io/biaoxyz/scaler-operator                                 v1                  dbee5320fdfa        2 hours ago         610 MB
scaler-operator                                                 v1                  dbee5320fdfa        2 hours ago         610 MB
...
...

root@myopenshift:tmp$ docker push docker.io/docker.io/scaler-operator:v1
The push refers to a repository [docker.io/docker.io/scaler-operator]
df87493a9d6d: Preparing
59090df7d243: Preparing
cf7287d2534f: Preparing
444c8cb7c2eb: Preparing
a3fc877dfcaa: Preparing
f5f9c982616a: Waiting
feb8f7b63c08: Waiting
47ca57f46f58: Waiting
13d859cf0192: Waiting
80817170de8e: Waiting
dd09b1c319a6: Waiting
f7b5949a5f66: Waiting
4616d642ce19: Waiting
be81e9b31e54: Waiting
63d9d56008cb: Waiting
56a62cb9d96c: Waiting
3f9dc45a1d02: Waiting
dac20332f7b5: Waiting
24f8e5ff1817: Waiting
1bdae1c8263a: Waiting
bc08b53be3d4: Waiting
071d8bd76517: Waiting
denied: requested access to the resource is denied
```
>> 结论就是：**要往本地仓库推的镜像，tag中间的部分随便玩；但是要往远端仓库推的镜像，tag必须按规定来**。

## 2.2

**真是日了狗了，我又发现如果带上用户名的话是可以推的。。。然后我上去docker.io的网页版看了下，还是只有那一个镜像，不过更新时间就是刚才。所以带多个docker.io看来不影响推送的。我擦，不管了。反正我按标准方法来推送镜像就行了，不会搞这些花样的。真是服了**。
```
root@myopenshift:tmp$ docker tag scaler-operator:v1 docker.io/docker.io/biaoxyz/scaler-operator:v1
root@myopenshift:tmp$ docker images
REPOSITORY                                                      TAG                 IMAGE ID            CREATED             SIZE
biaoxyz/scaler-operator                                         v1                  dbee5320fdfa        2 hours ago         610 MB
docker.io/biaoxyz/scaler-operator                               v1                  dbee5320fdfa        2 hours ago         610 MB
docker.io/docker.io/biaoxyz/scaler-operator                     v1                  dbee5320fdfa        2 hours ago         610 MB
docker.io/docker.io/scaler-operator                             v1                  dbee5320fdfa        2 hours ago         610 MB
quay.io/biaoxyz/scaler-operator                                 v1                  dbee5320fdfa        2 hours ago         610 MB
scaler-operator                                                 v1                  dbee5320fdfa        2 hours ago         610 MB
...
...

root@myopenshift:tmp$ docker push docker.io/docker.io/biaoxyz/scaler-operator:v1
The push refers to a repository [docker.io/docker.io/biaoxyz/scaler-operator]
df87493a9d6d: Pushed
59090df7d243: Pushed
cf7287d2534f: Pushed
444c8cb7c2eb: Pushed
a3fc877dfcaa: Pushed
f5f9c982616a: Pushed
feb8f7b63c08: Pushed
47ca57f46f58: Pushed
13d859cf0192: Pushed
80817170de8e: Pushed
dd09b1c319a6: Pushed
f7b5949a5f66: Pushed
4616d642ce19: Pushed
be81e9b31e54: Pushed
63d9d56008cb: Pushed
56a62cb9d96c: Pushed
3f9dc45a1d02: Pushed
dac20332f7b5: Pushed
24f8e5ff1817: Pushed
1bdae1c8263a: Pushed
bc08b53be3d4: Pushed
071d8bd76517: Pushed
v1: digest: sha256:81e056bbb515225f27509014dace8b6b56948e411ca995ab1ee4d527a5ceca64 size: 4916
```
