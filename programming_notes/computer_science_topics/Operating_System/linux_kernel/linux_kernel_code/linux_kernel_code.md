
Linux kernel https://blog.csdn.net/sinat_22338935/category_10848519.html
- linux内存管理（十四）-内存OOM触发分析 https://blog.csdn.net/sinat_22338935/article/details/118409427

内核源码 https://www.zhihu.com/column/c_1451239003220021249
- 搭建 Linux 内核网络调试环境（vscode + gdb + qemu） - wenfh2020的文章 - 知乎 https://zhuanlan.zhihu.com/p/445453676
  * > 5.更好方案
    + > 前段时间有一位热心网友在我的博客上留言，给出了一个更好的解决方案：描述了使用 docker 搭建调试环境。

### Copy On Write

Fork & 写时复制COW原理 https://www.luozhiyun.com/archives/710

COW奶牛！Copy On Write机制了解一下 https://developer.aliyun.com/article/893644
- > **一、Linux下的copy-on-write**
  * > 在说明Linux下的copy-on-write机制前，我们首先要知道两个函数：`fork()`和exec()。需要注意的是exec()并不是一个特定的函数, 它是一组函数的统称, 它包括了execl()、execlp()、execv()、execle()、execve()、execvp()。
