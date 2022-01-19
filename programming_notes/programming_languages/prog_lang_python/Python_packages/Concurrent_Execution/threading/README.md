
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
