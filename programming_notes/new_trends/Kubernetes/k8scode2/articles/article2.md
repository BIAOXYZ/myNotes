
【From Draveness's Blog 【面向信仰编程】】： `tag/kubernetes` https://draveness.me/tags/kubernetes
- 谈 Kubernetes 的架构设计与实现原理 https://draveness.me/understanding-kubernetes/
- 从 Kubernetes 中的对象谈起 https://draveness.me/kubernetes-object-intro/
- 详解 Kubernetes Pod 的实现原理 https://draveness.me/kubernetes-pod
- 详解 Kubernetes Deployment 的实现原理 https://draveness.me/kubernetes-deployment
- 详解 Kubernetes DaemonSet 的实现原理 https://draveness.me/kubernetes-daemonset
- 详解 Kubernetes Job 和 CronJob 的实现原理 https://draveness.me/kubernetes-job-cronjob
- 详解 Kubernetes 垃圾收集器的实现原理 https://draveness.me/kubernetes-garbage-collector

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:

详解 Kubernetes Pod 的实现原理 https://draveness.me/kubernetes-pod
- > Pod 的创建都是通过 `SyncPod` 来实现的，创建的过程大体上可以分为六个步骤：
  ```console
  1.计算 Pod 中沙盒和容器的变更；
  2.强制停止 Pod 对应的沙盒；
  3.强制停止所有不应该运行的容器；
  4.为 Pod 创建新的沙盒；
  5.创建 Pod 规格中指定的初始化容器；
  6.依次创建 Pod 规格中指定的常规容器；
  ```
