
# 1

【[:star:][`*`]】 Linux网络编程 --------- Socket编程---最浅显易懂的介绍 https://blog.csdn.net/alpha_love/article/details/62043077
- > **1、网络中进程之间如何通信？**
- > **2、什么是Socket？**
  * > 上面我们已经知道网络中的进程是通过socket来通信的，那什么是socket呢？socket起源于Unix，而Unix/Linux基本哲学之一就是“一切皆文件”，都可以用“打开open –> 读写write/read –> 关闭close”模式来操作。我的理解就是Socket就是该模式的一个实现，***<ins>`socket`即是一种特殊的文件，一些socket函数就是对其进行的操作（读/写IO、打开、关闭）</ins>***，这些函数我们在后面进行介绍。
- > **3、socket的基本操作**
  * > 既然socket是“open—write/read—close”模式的一种实现，那么socket就提供了这些操作对应的函数接口。下面以TCP为例，介绍几个基本的socket接口函数。
- > **3.1、socket()函数**
  ```c
  int socket(int domain, int type, int protocol);
  ```
  * > socket函数对应于普通文件的打开操作。普通文件的打开操作返回一个文件描述字，而`socket()`用于创建一个`socket描述符`（socket descriptor），它唯一标识一个socket。这个socket描述字跟文件描述字一样，后续的操作都有用到它，把它作为参数，通过它来进行一些读写操作。
