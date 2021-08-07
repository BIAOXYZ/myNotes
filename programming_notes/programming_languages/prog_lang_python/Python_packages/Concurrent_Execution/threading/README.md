
# 官方

threading --- 基于线程的并行 https://docs.python.org/zh-cn/3/library/threading.html
- > **CPython implementation detail**: 在 CPython 中，由于存在 [全局解释器锁](https://docs.python.org/zh-cn/3/glossary.html#term-global-interpreter-lock)，<ins>***同一时刻只有一个线程可以执行 Python 代码***</ins>（虽然某些性能导向的库可能会去除此限制）。 如果你想让你的应用更好地利用多核心计算机的计算资源，推荐你使用 `multiprocessing` 或 `concurrent.futures.ProcessPoolExecutor`。 但是，如果你想要同时运行多个 I/O 密集型任务，则多线程仍然是一个合适的模型。

# 较系统攻略

第十二章：并发编程 https://python3-cookbook.readthedocs.io/zh_CN/latest/chapters/p12_concurrency.html

An Intro to Threading in Python https://realpython.com/intro-to-python-threading/

# 其他

Python 多线程 https://www.runoob.com/python/python-multithreading.html

Python  threading实现多线程 基础篇 - 木头人的文章 - 知乎 https://zhuanlan.zhihu.com/p/91601448
