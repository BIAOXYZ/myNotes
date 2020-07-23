
【[:star:][`*`]】 The Almighty Pause Container https://www.ianlewis.org/en/almighty-pause-container

【[:star:][`*`]】 What are Kubernetes Pods Anyway? https://www.ianlewis.org/en/what-are-kubernetes-pods-anyway
- > **Containers aren't Containers**
- > Many folks know this already but Linux "containers" don't really exist. There is no thing called a "container" in Linux. Containers as everyone knows them are normal processes that are executed using two features of the Linux kernel called namespaces and cgroups. Namespaces allow you to provide a "view" to the process that hides everything outside of those namespaces, thus giving it its own environment to run in. This makes it so processes can't see or interfere with other processes:
  ```
  Namespaces include:
  Hostname
  Process IDs
  File System
  Network interfaces
  Inter-Process Communication (IPC)
  ```
