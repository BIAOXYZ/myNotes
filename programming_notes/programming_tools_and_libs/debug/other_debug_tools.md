
# debug tool general

## strace

***参见strace命令专门文件***

## crash

Linux kernel crash utility https://github.com/crash-utility/crash || https://crash-utility.github.io/

crash(8) — Linux manual page https://man7.org/linux/man-pages/man8/crash.8.html

使用crash分析linux内核崩溃转储文件vmcore https://www.jianshu.com/p/824908137f59
- > crash工具，跟gdb很类似，它可以交互的分析运行中的内核，也可以分析由kdump、netdump、diskdump、xendump产生的core dump文件。

linux内核调试之 crash分析dump文件 - 小乐叔叔的文章 - 知乎 https://zhuanlan.zhihu.com/p/280751207

Ubuntu 20.04 Kdump + Crash 初体验 https://www.ebpf.top/post/ubuntu_kdump_crash/

# nsenter

巧用 Nsenter 调取宿主机工具调试容器内程序 https://cloud.tencent.com/developer/article/1730699

# debug tool for microservices

Debugging microservices - Squash vs. Telepresence https://www.weave.works/blog/debugging-microservices-squash-vs-telepresence
- Telepresence https://www.telepresence.io/
- Squash: The debugger for microservices https://squash.solo.io/

Solving the challenges of debugging microservices on a container platform https://developers.redhat.com/blog/2018/11/27/microservices-debugging-openshift-kubernetes/

# Telepresence

TELEPRESENCE: FAST, LOCAL DEVELOPMENT FOR KUBERNETES AND OPENSHIFT MICROSERVICES https://www.telepresence.io/

Debug a Kubernetes service locally https://www.telepresence.io/tutorials/kubernetes

k8s官方推荐了`telepresence`:
- Developing and debugging services locally https://kubernetes.io/docs/tasks/debug-application-cluster/local-debugging/
- 本地开发和调试 service https://k8smeetup.github.io/docs/tasks/debug-application-cluster/local-debugging/

# Squash

Squash https://squash.solo.io/

Squash: The debugger for microservices https://github.com/solo-io/squash

# not matured 

## kubectl-debug

简化 Pod 故障诊断: kubectl-debug 介绍 https://aleiwu.com/post/kubectl-debug-intro/
- nsenter https://github.com/jpetazzo/nsenter
  * > There are differences between nsenter and docker exec; namely, nsenter doesn't enter the cgroups, and therefore evades resource limitations. The potential benefit of this would be debugging and external audit, but for remote access, docker exec is the current recommended approach.

## docker-debug

cdebug - a swiss army knife of container debugging https://github.com/iximiuz/cdebug

docker 容器调试新姿势 https://blog.zeromake.com/pages/docker-debug

# 小众debug工具

drgn -- Programmable debugger https://github.com/osandov/drgn

buildg: A tool to interactively debug Dockerfile https://github.com/ktock/buildg

## dbx

dbx (debugger) https://en.wikipedia.org/wiki/Dbx_(debugger)
- > `dbx` is a source-level debugger found primarily on `Solaris`, `AIX`, `IRIX`, `Tru64 UNIX`, `Linux` and `BSD` operating systems.
- > `dbx` is also available on IBM `z/OS` systems, in the UNIX System Services component.
  >> //notes：虽然说是这么说，但是好像只有 `Solaris` 和 `z/OS` 上才有吧。也没有用过，基本就只是记录下知道有这么个东西就行。

dbx — Use the debugger https://www.ibm.com/docs/en/zos/2.2.0?topic=descriptions-dbx-use-debugger

Debugging Your Program With dbx https://docs.oracle.com/cd/E18659_01/html/821-1380/blabf.html
