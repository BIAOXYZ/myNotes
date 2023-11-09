
# other container techniques

【[`*`][:star:]】 白话 Kubernetes Runtime https://mp.weixin.qq.com/s/8RvbcvWFSq1snfLorLyhEA || https://aleiwu.com/post/cncf-runtime-landscape/ || https://zhuanlan.zhihu.com/p/58784095

【[`*`][:star:]】 The differences between Docker, containerd, CRI-O and runc https://www.tutorialworks.com/difference-docker-containerd-runc-crio-oci/
- > **A bird’s eye view**
  * > ![](https://www.tutorialworks.com/assets/images/container-ecosystem.drawio.png)
- > **How the Docker stack works**
  * > ![](https://www.tutorialworks.com/assets/images/container-ecosystem-docker.drawio.png)
  * > **What are the lower-level tools in the Docker stack?**
    + > (Lowest-level) The low-level container runtime. [`runc`](https://github.com/opencontainers/runc) is a low-level container runtime. It uses the native features of Linux to create and run containers. It follows the OCI standard, and it includes [`libcontainer`](https://pkg.go.dev/github.com/opencontainers/runc/libcontainer), a Go library for creating containers.
    + > The high-level container runtime. [`containerd`](https://containerd.io/) sits above the low-level runtime, and adds a bunch of features, like transferring images, storage, and networking. It also fully supports the OCI spec.
    + > The Docker daemon. [`dockerd`](https://docs.docker.com/engine/reference/commandline/dockerd/) is a daemon process (a long-running process that stays running in the background) which provides a standard API, and talks to the container runtime.
    + > (Highest level) The Docker CLI tool. Finally, [`docker-cli`](https://github.com/docker/cli) gives you the power to interact with the Docker daemon using `docker` ... commands. This lets you control containers without needing to understand the lower levels.
    + > So, in reality, when you run a container with `docker`, you’re actually running it ***through the `Docker daemon`***, which ***calls `containerd`***, which then ***uses `runc`***.
      >> 【[`*`][:star:]】 //notes：所以其实用 docker 运行容器的过程就是：`docker cli -> docker daemon（也就是 dockerd） -> containerd -> runc`

Container runtimes: clarity https://medium.com/cri-o/container-runtimes-clarity-342b62172dc3
- > As a maintainer of the CRI-O container runtime for kubernetes I often get asked the following questions at conferences and meetups:
  ```
  Is CRI-O a replacement for Docker?
  Is containerd a replacement for CRI-O?
  ```

Docker vs CRI-O vs Containerd https://computingforgeeks.com/docker-vs-cri-o-vs-containerd/

Why Red Hat is investing in CRI-O and Podman https://www.redhat.com/en/blog/why-red-hat-investing-cri-o-and-podman

A Comprehensive Container Runtime Comparison https://www.capitalone.com/tech/cloud/container-runtime/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# OCI and CRI

>> //notes：最大的区别是：OCI纯是container社区搞的；而CRI是kubernetes社区搞的，并且还有CNI、CSI等。

Welcome To The Container Jungle: Docker vs. containerd vs. Nabla vs. Kata vs. Firecracker and more! https://www.inovex.de/blog/containers-docker-containerd-nabla-kata-firecracker/

## OCI (Open Container Initiative)

Open Container Initiative https://en.wikipedia.org/wiki/Open_Container_Initiative

## CRI (Container Runtime Interface)

Introducing Container Runtime Interface (CRI) in Kubernetes https://kubernetes.io/blog/2016/12/container-runtime-interface-cri-in-kubernetes/

An overview of the Kubernetes Container Runtime Interface (CRI) https://developer.ibm.com/technologies/containers/blogs/kube-cri-overview/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## runc

runc -- CLI tool for spawning and running containers according to the OCI specification https://github.com/opencontainers/runc
> https://www.opencontainers.org/

当前标签: docker https://www.cnblogs.com/sparkdev/tag/docker/default.html
- RunC 简介 https://www.cnblogs.com/sparkdev/p/9032209.html
- 从 docker 到 runC https://www.cnblogs.com/sparkdev/p/9129334.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Nabla

Secure Containers https://researcher.watson.ibm.com/researcher/view_group.php?id=9510
- Nabla containers: a new approach to container isolation https://nabla-containers.github.io/

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Library OS and Unikernel

Unikernel https://en.wikipedia.org/wiki/Unikernel

Unikernels as processes https://blog.acolyer.org/2018/11/14/unikernels-as-processes/

Unikernel Systems Joins Docker https://blog.docker.com/2016/01/unikernel/

Unikernel：从不入门到入门 http://gaocegege.com/Blog/%E5%AE%89%E5%88%A9/unikernel-book
- > Unikernels: Beyond Containers to the Next Generation of Cloud 是 Russ Pavlicek 的一本动物书（虽然是 O’Reilly 的，但是封面不是动物，是石榴），这本书对 Unikernel 有着比较全面的介绍，而且电子书是免费的，值得一读。
  >> Unikernels https://www.oreilly.com/library/view/unikernels/9781492042815/
- > CSP课堂笔记之UniKernel http://gaocegege.com/Blog/csp/unikernel
- > Unikernels - Rethinking Cloud Infrastructure http://unikernel.org/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# Kata Containers

## Kata Containers官方

The speed of containers, the security of VMs https://katacontainers.io/

Docs https://katacontainers.io/docs/

Kata Containers https://github.com/kata-containers

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## katacontainers相关文章

Kata Containers https://www.binss.me/blog/what-is-kata-containers/

初识 Kata Containers https://www.hi-linux.com/posts/23259.html

黑客松Demo: Kata 的下一代镜像系统 https://mp.weixin.qq.com/s/qVgdzwCQQ2Jtxx40_CTUlw

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## Virtio-fs

Virtio-fs https://virtio-fs.gitlab.io/

Virtio-fs介绍与性能优化 https://kernel.taobao.org/2019/11/virtio-fs-intro-and-perf-optimize/

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# gVisor

## gVisor官方

gVisor -- A container sandbox runtime focused on security, efficiency, and ease of use. https://gvisor.dev/

gVisor: Container Runtime Sandbox https://github.com/google/gvisor

:u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307::u6307:

## gVisor其他

gVisor：谷歌发布的一个用于提供安全隔离的轻量级容器运行时沙箱 https://www.infoq.cn/article/2018/05/gvisor-container-sandbox

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

# LightVM

启动仅需2.3ms比Docker还快的新技术，能否改变容器市场格局？ https://www.kubernetes.org.cn/3222.html

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

"Distroless" Container Images https://github.com/GoogleContainerTools/distroless
- > "Distroless" images contain only your application and its runtime dependencies. They do not contain package managers, shells or any other programs you would expect to find in a standard Linux distribution.
- > **Why should I use distroless images?**
  * > Restricting what's in your runtime container to precisely what's necessary for your app is a best practice employed by Google and other tech giants that have used containers in production for many years. It improves the signal to noise of scanners (e.g. CVE) and reduces the burden of establishing provenance to just what you need.
  * > Distroless images are _very small_. The smallest distroless image, `gcr.io/distroless/static-debian11`, is around `2 MiB`. That's about `50%` of the size of `alpine` (`~5 MiB`), and less than `2%` of the size of `debian` (`124 MiB`).
