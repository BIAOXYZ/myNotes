
# 官方

threading --- 基于线程的并行 https://docs.python.org/zh-cn/3/library/threading.html
- > **CPython implementation detail**: 在 CPython 中，由于存在 [全局解释器锁](https://docs.python.org/zh-cn/3/glossary.html#term-global-interpreter-lock)，<ins>***同一时刻只有一个线程可以执行 Python 代码***</ins>（虽然某些性能导向的库可能会去除此限制）。 如果你想让你的应用更好地利用多核心计算机的计算资源，推荐你使用 `multiprocessing` 或 `concurrent.futures.ProcessPoolExecutor`。 但是，如果你想要同时运行多个 I/O 密集型任务，则多线程仍然是一个合适的模型。
- > **线程本地数据**
- > **线程对象**
  * > 当线程对象一但被创建，其活动一定会因调用线程的 `start()` 方法开始。这会在独立的控制线程调用 `run()` 方法。
  * > 一旦线程活动开始，该线程会被认为是 '存活的' 。当它的 `run()` 方法终结了（不管是正常的还是抛出未被处理的异常），就不是'存活的'。 `is_alive()` 方法用于检查线程是否存活。
  * > 其他线程可以调用一个线程的 `join()` 方法。这会阻塞调用该方法的线程，直到被调用 `join()` 方法的线程终结。
- > **锁对象**
  * > 原始锁是一个 ***在锁定时不属于特定线程*** 的同步基元组件。在Python中，它是能用的最低级的同步基元组件，由 [`_thread`](https://docs.python.org/zh-cn/3/library/_thread.html#module-_thread) 扩展模块直接实现。
  * > 原始锁处于 "锁定" 或者 "非锁定" 两种状态之一。***它被创建时为非锁定状态***。它有两个基本方法， `acquire()` 和 `release()` 。当状态为非锁定时， `acquire()` 将状态改为 锁定 并立即返回。当状态是锁定时， `acquire()` 将阻塞至其他线程调用 `release()` 将其改为非锁定状态，然后 `acquire()` 调用重置其为锁定状态并返回。 `release()` 只在锁定状态下调用； 它将状态改为非锁定并立即返回。如果尝试释放一个非锁定的锁，则会引发 `RuntimeError`  异常。

Using locks, conditions, and semaphores in the with statement https://docs.python.org/3/library/threading.html#with-locks
- > All of the objects provided by this module that have `acquire()` and `release()` methods can be used as context managers for a `with` statement. The `acquire()` method will be called when the block is entered, and `release()` will be called when the block is exited. Hence, the following snippet:
  ```py
  with some_lock:
      # do something...
  ```
- > is equivalent to:
  ```py
  some_lock.acquire()
  try:
      # do something...
  finally:
      some_lock.release()
  ```
- > Currently, `Lock`, `RLock`, `Condition`, `Semaphore`, and `BoundedSemaphore` objects may be used as `with` statement context managers.

# 较系统攻略

第十二章：并发编程 https://python3-cookbook.readthedocs.io/zh_CN/latest/chapters/p12_concurrency.html

An Intro to Threading in Python https://realpython.com/intro-to-python-threading/
>> //notes：笔记参见realpython目录里相应的部分。

# 其他

Python 多线程 https://www.runoob.com/python/python-multithreading.html

Python  threading实现多线程 基础篇 - 木头人的文章 - 知乎 https://zhuanlan.zhihu.com/p/91601448

python：threading.Thread类的使用详解 https://blog.csdn.net/drdairen/article/details/60962439
- > Python Thread类表示在单独的控制线程中运行的活动。有两种方法可以指定这种活动：
  * > 1、给构造函数传递回调对象
    ```py
    mthread=threading.Thread(target=xxxx,args=(xxxx))
    mthread.start()
    ```
  * > 2、在子类中重写 `run()` 方法
    + > 派生类中重写了父类`threading.Thread`的`run()`方法，其他方法（除了构造函数)都不应在子类中被重写，换句话说，在子类中只有`_init_()`和`run()`方法被重写。使用线程的时候先生成一个子线程类的对象，然后对象调用`start()`方法就可以运行线程啦（***start调用run***）
- > 下面我们进入本文的正题threading.Thread类的常用函数与方法：
  * > 1、一旦线程对象被创建，它的活动需要通过调用线程的start()方法来启动。这方法再调用控制线程中的run方法。
  * > 2、一旦线程被激活，则这线程被认为是’alive’(活动)。当它的run()方法终止时-正常退出或抛出未处理的异常，则活动状态停止。isAlive()方法测试线程是否是活动的。大致上，线程从 start()调用开始那点至它的run()方法中止返回时，都被认为是活动的。模块函数enumerate()返回活动线程的列表。
  * > 3、一个线程能调用别的线程的join()方法。这将阻塞调用线程，直到拥有join()方法的线程的调用终止。
  * > 4、线程有名字，默认的是Thread-No形式的，名字能传给构造函数，通过setName()方法设置，用getName()方法获取。
  * > 5、线程能被标识为’daemon thread’(守护线程).这标志的特点是当剩下的全是守护线程时，则Python程序退出。它的初始值继承于创建线程。标志用setDaemon()方法设置，用isDaemon()获取。
  * > 6、存在’main thread’(主线程),它对应于Python程序的初始控制线程。它不是后台线程。
  * > 8、如果子线程重写了构造函数，它应保证调用基类的构造函数(Thread._init_())，在线程中进行其他工作之前。（也就是派生类刚开始就要调用基类的构造函数）
  * > 9、start() 启动线程活动。在每个线程对象中最多被调用一次。它安排对象的run() 被调用在一单独的控制线程中。
  * > 10、run() 用以表示线程活动的方法。你可能在Python Thread类的子类重写这方法。标准的 run()方法调用作为target传递给对象构造函数的回调对象。
  * > 11、join([timeout])
    + > 等待至线程中止。阻塞调用线程直至线程的join() 方法被调用中止-正常退出或者抛出未处理的异常-或者是可选的超时发生。timeout参数不是None,它应当是浮点数指明以秒计的操作超时值。因为join()总是返回None，你必须调用isAlive()来判别超时是否发生。当timeout 参数没有被指定或者是None时，操作将被阻塞直至线程中止。
    + > 线程能被join()许多次。线程不能调用自身的join()，因为这将会引起死锁。在线程启动之前尝试调用join()会发生错误。
