
求 Python 练习题 https://www.v2ex.com/t/714540
- > 类似这种的吗 https://www.runoob.com/python3/python3-examples.html
- > https://www.hackerrank.com/domains/python
- > https://www.codewars.com/
- > codewars +1 做完后还可以参考别人的答案…… best practice 什么的 <br> 7-8 级的题适合入门，4 级以上的题大部分都比较难，很多题不折腾几个小时出不来。初段题是不是就是接近一个小课题？另外还有各种语言，js，java，rust，go 等等

Python 为什么不支持 switch 语句？ https://www.v2ex.com/t/713768
- > 本文出自“Python 为什么”系列，请查看全部文章：
  >> `#Python为什么` https://mp.weixin.qq.com/mp/appmsgalbum?__biz=MzUyOTk2MTcwNg==&action=getalbum&album_id=1338406397180084225

【[:star:][`*`]】 宣传一下 Cyberbrain，真正解放程序员的 Python 调试工具 https://www.v2ex.com/t/713201
- > https://github.com/laike9m/Cyberbrain
- > 简单来说，Cyberbrain 可以实现精确的变量溯源，并且让用户查看变量在任意时刻的值。这些传统的 debugger 都做不到。
- > 看示意图好像是用 github-codespaces 开发的？
  >> #12 我申请了 codespaces 但还没给我批。之后会支持。目前支持 VS Code 和 Gitpod
- > 这类 trace 工具让我很困惑的一点就是几亿次循环那种变量变化特别快的，然后又是 2G 的 json 在里面变来变去的怎么办。
  >> #14 这确实是个问题，不过我有大致的解决思路，就是隔一段时间把数据 dump 到磁盘一次。目前还没有着手优化这一块，不过是在计划内的。
- > 感觉和 pysnooper 功能差不多呀
  >> 我不喜欢自吹，但是 cyberbrain 完爆 snooper （虽然目前还不支持追踪深层的函数调用）。pysnooper 真的没什么技术含量，它的核心功能我两天就能写出来
  >>
  >> pysnooper 只能告诉你 a 变了，但它不能告诉你 a 变化的来源，以及变化来源的来源，而这是 cyberbrain 的核心功能。
- > 追踪来源有点意思，那确实跟 pysnooper 侧重点不一样了
  >> 恩，因为 pysnooper 分析的是行级别的变化，而 cb 是在字节码级别做追踪的，拿到的信息要多太多，准确度也更高
- > async 的支持怎么样？
  >> 在项目页面有后续版本的路线图，预计会在 4.0 支持。当然，我更希望有人能加入一起做，如果是我一个人的话 async 确实要等比较久了
- > 很不错，下一版开发 go trace?
  >> #27 谢谢。Cyberbrain 是 Python only 的，Go 可能需要更熟悉 Go 的人来开发，而且我怀疑在 Go 里能否拿到需要的信息
- > #26 怪我。。。我 py 版本 367 的。
  >> #29 嗯，支持 Python 3.7+（过几天就支持 3.9 ）。主要是因为用了一个 3.7 里新加的 API
- > 做 Go 的和这个完全不一样了，需要面向二进制配合符号做，部分功能恐怕需要魔改 runtime
- > 是不是不支持递归函数啊，刚刚随手拿裴波那契数列的递归写法试了一下，结果报 AssertionError 了，又试了几个其他的递归函数，无一例外全部报错。正常写法的函数都没问题，应该不是我的环境的原因吧
  >> #33 非常感谢，能帮忙提个 issue 吗？我会尽快修复 https://github.com/laike9m/Cyberbrain/issues/new
  >>> https://github.com/laike9m/Cyberbrain/issues/43
- > 我不太懂这些，不过这个变量可视化的部分和 https://marketplace.visualstudio.com/items?itemName=hediet.debug-visualizer 有什么差别吗
  >> #37 哈哈，它们长得像是因为都用了 vis-network 这个可视化库🙈 不过目的是完全不一样的。debug-visulizer 是可视化数据结构，Cyberbrain 是可视化代码执行流程

python3 新特性这么多，你常用的是什么？ https://www.v2ex.com/t/713227
- > type hint，dataclass
- > type hint 和 f-string，应该大多数人都是这两个
- > asyncio 吧 python2 gevent 文档太少
- > async/await asyncio typehints dataclass f-string
- > f-string dataclass enum  type-hint 还能帮助代码提示

请教 Python 多线程内存不释放怎么排查 https://www.v2ex.com/t/712846

Python 类相关问题 https://www.v2ex.com/t/702580

在 python3 中, 字节流如何转换成字符串 https://www.v2ex.com/t/695185

《捕蛇者说》16 期发布： Goodbye Python 2, Hello Python 3！ https://www.v2ex.com/t/693282

有在线编写 Python 代码并能执行的开源项目吗 https://www.v2ex.com/t/692173
- > IBM Cloud Fonudray 和 Github Action 可以去看一下。
- > Polynote
- > https://e.coding.net/login 在线 VS Code，不开源，五人以下免费。

Python 多重继承的问题 为什么以下代码里 Base 的 __init__ 没有被调用 https://www.v2ex.com/t/690995

Python 多线程的问题 https://www.v2ex.com/t/674432
```py
total = 0

def add():
    #1. dosomething1
    #2. io 操作
    # 1. dosomething3
    global total
    for i in range(1000000):
        total += 1
def desc():
    global total
    for i in range(1000000):
        total -= 1

import threading
thread1 = threading.Thread(target=add)
thread2 = threading.Thread(target=desc)
thread1.start()
thread2.start()

thread1.join()
thread2.join()
print(total) # 178412
```
- > 简单来说 total 不是线程安全的，这个不只在 Python 中会出现，而是任何多线程语言下都会出现的现象，解决方案就是访问前加锁，或者用原子操作
- > GIL：执行是单线程的，不代表线程的上下文是受保护的。即单线程的执行方式!=线程安全。
- > 你可以 dis 看下生成的字节指令就知道了，+= 1 也是需要好多条指令的，python 的 GIL 应该只是在单条字节指令保证原子性吧，但是你一行代码很多时候都是多条字节指令的吧
- > += 和 -= 不是原子的
- > 1.GIL 意思是任何时候只有一个线程运行 <br> 2.因为增量赋值不是原子操作，具体可看 dis.dis('a += 1') 的字节码不止一步 <br> 3.线程是系统调度的，你不知道何时切换 <br> 4.好，那你怎么就知道在做增量赋值的字节码某一步的时候，不会切换到了另一个线程呢？
- > 全局定义一个 lock = threading.Lock()，+=、-=之前增加一个 with lock:的块
  >> notes：我查了也试了下，比较简单的做法是用`lock.acquire()`和`lock.release()`把`total += 1`和`total -= 1`包起来就行。参照下面这个页面：
  >>> https://python-parallel-programmning-cookbook.readthedocs.io/zh_CN/latest/chapter2/06_Thread_synchronization_with_Lock_and_Rlock.html

请教： Python 获取 shell 自定义变量的值。 https://www.v2ex.com/t/658012
```console
我在当前 shell 中定义了 test 这个自定义变量，同时，我启动了一个 Py 脚本，这个 Py 脚本有没有办法获取当前 shell 的
自定义变量（比如这个$test ）的值？

要求：不将自定义变量导出为环境变量。
```
- > 你这需求也太扭曲了，为啥会有这种需求，原始问题是什么？而扭曲的需求只有用扭曲的办法解决了：gdb attach 上去找
  >> 
  ```py
  #!/usr/bin/env python3
  from pygdbmi.gdbcontroller import GdbController
  import os

  gdbmi = GdbController()
  gdbmi.write(f"attach {os.getppid()}")
  res = gdbmi.write('p (char *)get_string_value("foo")')

  for mes in res:
      if "$1" in str(mes.get("payload", "")):
          print(mes["payload"])
  ```

Python 的协程到底有啥用啊… 
- > 一篇文章理解Python异步编程的基本原理 https://mp.weixin.qq.com/s/spayiLNuTnFVOWWeW-jkwQ
  * > 以 request 请求URL 为例，requests 发起请求，也许只需要0.01秒的时间。然后程序就卡住，等待网站返回。请求数据通过网络传到网站服务器，网站服务器发起数据库查询请求，网站服务器返回数据，数据经过网线传回你的电脑。requests 收到数据以后继续后面的操作。 <br> 大量的时间浪费在等待网站返回数据。如果我们可以充分利用这个等待时间，就能发起更多的请求。而这就是异步请求为什么有用的原因。 <br> 但对于需要大量计算任务的代码来说，CPU 始终处于高速运转的状态，没有等待，所以就不存在利用等待时间做其它事情的说法。 <br> 所以：**异步只适用于 I/O 操作相关的代码，不适用于非 I/O操作**。
- > Python异步编程详解 https://hatboy.github.io/2019/02/16/Python%E5%BC%82%E6%AD%A5%E7%BC%96%E7%A8%8B%E8%AF%A6%E8%A7%A3/
- > 协程是单线程的，因此你必须保证你的所有“阻塞”操作都是异步的，不然对性能没有任何提升。比如你用 requests 写爬虫程序。由于 requests 的操作都是阻塞的，用协程不会带来任何的性能提升。要想提升性能得把 requests 换成非阻塞的库，如 aiohttp 。
- > 推荐一篇文章， https://snarky.ca/how-the-heck-does-async-await-work-in-python-3-5/  <br> 作者从头讲解了 Python 协程的工作原理，并实现了一个简易的事件循环，有助于理解基于 Python 协程的工作原理。 <br> 但是这个说的是原理，目前可能不太适合你看。之后有兴趣可以看下，看完可以再读下 asyncio 库的源码。Python 协程本质是依赖 IO 多路复用和 yield 去实现异步的，所以只有网络 IO 才有必要使用协程。
- > 协程的本质是保存当前函数或者例程的运行状态，并主动让出 CPU 资源，使得和当前函数处于"平级"的函数或者是例程能够得到 CPU 资源，并于原有保存点继续执行，整个过程只有少量的函数运行点恢复操作，没有重量级的线程(进程)上下文切换，所以在同样任务的情况下，协程比线程、进程拥有更高的执行效率。Python 的协程，对我个人而言还不如线程好用，宁愿使用 gevent patch，也不愿意使用 asyncio 。协程还是 Golang 用起来更加顺手。
- > 协程仅使用于类似爬虫或服务这种持续性 io 密集的程序，其他平砍算法可以解决的事情用协程就是增加心智负担。

Python3 里面 u 和 U 的区别是什么 https://www.v2ex.com/t/655586
- > https://stackoverflow.com/questions/46132917/python-3-and-x-vs-u-vs-u-in-string-encoding-and-why

字典.keys()获得的键列表元素顺序是随机的吗？ https://www.v2ex.com/t/634283
- > 随机的，需要顺序，用 ordered dict
- > dart 有一个叫 LinkedHashMap,那是有顺序的
- > Python 3.7+ https://docs.python.org/3.7/whatsnew/3.7.html <br> In Python 3.7.0 the insertion-order preservation nature of dict objects has been declared to be an official part of the Python language spec. Therefore, you can depend on it.
- > 虽然有 order dict，但内部是有序的。如同上面老哥所述，在 3.x （ x 是几我给忘了）后的版本是有序的

Python 为什么趋近于零的数字会表示成 5.96046448e-08 https://www.v2ex.com/t/629937
- > 15. 浮点算术：争议和限制 https://docs.python.org/zh-cn/3.8/tutorial/floatingpoint.html

刚搞懂一个 logging 的用法，分享一下。 https://www.v2ex.com/t/613320

Python 之父开博客写的解析器系列文章 https://www.v2ex.com/t/588878

cpython 底层实现笔记 https://www.v2ex.com/t/560173
> Dive into CPython internals, trying to illustrate every detail of CPython implementation | CPython 源码阅读笔记, 多图展示底层实现细节 https://github.com/zpoint/CPython-Internals

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
