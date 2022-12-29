
# 1

【[:star:][`*`]】 【加速】multiprocessing多线程、多进程、并行、numba https://www.guofei.site/2021/02/13/python_speedup.html
- > **前言**
  * > 多线程。
    + > 推荐使用 `from multiprocessing.dummy import Pool as ThreadPool`
    + > python 还提供了2个多线程接口 `thread` 提供底层接口。`threading` 提供高等级接口。）
    + > 一个进程中启动多个线程
    + > 由于Python中使用了全局解释锁GIL，导致Python中的多线程并不是真并行，而是“交替执行” 。
    + > ***<ins>所以 Python 多线程适合IO密集型任务，而不适合计算密集型任务</ins>***。
    + > 甚至在多核CPU上用多线程执行计算密集任务，由于 GIL 的存在，会导致多核争抢1个GIL，让任务比普通的更慢。
  * > 多进程（Python 提供 `mutliprocess` 作为多进程接口。）
    + > 推荐使用 `from multiprocessing import Pool`
    + > 由于Python中GIL的原因，对于计算密集型任务，Python下比较好的并行方式是使用多进程，这样可以非常有效的使用CPU资源。
    + > 同一时间执行的进程数量取决你电脑的CPU核心数。
  * > 测试函数：
    ```py
    import time
    import datetime
    import os
    import multiprocessing
    from multiprocessing.dummy import Pool as ThreadPool
    from multiprocessing import Pool
    import numpy as np
    multiprocessing.set_start_method('fork')

    print(__name__, os.getpid())

    def costly_task(inputs):
        task_num, task_type = inputs
        # task_mode can be 'io_costly', 'cpu_costly'
        ppid = os.getppid()
        pid = os.getpid()
        start_time = datetime.datetime.now().strftime('%S.%f')
        if task_type == 'io_costly':
            time.sleep(1)
            task_res = 0
        else:
            n = 500000
            step1 = [np.log(i + 1) for i in range(n)] + [np.power(i, 1.1) for i in range(n)]
            task_res = sum(step1)
        end_time = datetime.datetime.now().strftime('%S.%f')
        return task_res

    if __name__ == '__main__':
        for task_type in ('io_costly', 'cpu_costly'):
            start = datetime.datetime.now()
            list(map(costly_task, [[i, task_type] for i in range(10)]))
            print(task_type, ', 普通任务', datetime.datetime.now() - start)

            start = datetime.datetime.now()
            pool = ThreadPool()  # ThreadPool(4), 不指定进程数，则使用全部线程
            pool.map(costly_task, [[i, task_type] for i in range(10)])  # 返回list，就是结果
            print(task_type, ', 多线程', datetime.datetime.now() - start)

            start = datetime.datetime.now()
            pool = Pool()
            pool.map(costly_task, [[i, task_type] for i in range(10)])  # 返回list，就是结果
            print(task_type, ', 多进程', datetime.datetime.now() - start)
    ```
  * > 输出：
    ```console
    io_costly , 普通任务 0:00:10.077721
    io_costly , 多线程 0:00:03.075839
    io_costly , 多进程 0:00:04.180210
    cpu_costly , 普通任务 0:00:39.668068
    cpu_costly , 多线程 0:00:43.041522
    cpu_costly , 多进程 0:00:25.812865
    ```
    ```console
    # 个人实战的输出
    __main__ 3005392
    io_costly , 普通任务 0:00:10.009790
    io_costly , 多线程 0:00:02.006241
    io_costly , 多进程 0:00:02.032290
    cpu_costly , 普通任务 0:00:15.888063
    cpu_costly , 多线程 0:00:16.931809
    cpu_costly , 多进程 0:00:03.356995
    ```
  * > 输出符合预期：
    + > 普通任务是最慢的
    + > ***IO密集型任务，多线程最快，多进程因为会抢CPU锁所以比多线程稍慢一些***。
    + > ***CPU密集型任务，本身已经占满CPU了，所以多线程不会更快，反而因为反复切换资源更慢一些。多进程能加快速度***。
  * > 另外，多进程下，需要加一行，`multiprocessing.set_start_method('fork')` ：
    + > `spawn`: default on windows，父进程开启一个新进程，新进程只继承父进程 `run()` 方法相关的必须资源
    + > `fork`: available on unix, default on unix. 使用 `os.fork()` 来 fork
    + > `forkserver`: 同上，但更安全。
  * > 如果用 `spawn` 模式，且不在 `if __name__ == '__main__':` 下，会进入无限递归然后报错。windows 只有 `spawn` 模式，目前无法解决，考虑用 `sys.platform == 'win32'` 判断一下转多线程）
  * > 代码解释

python多进程总结 https://www.cnblogs.com/fengf233/p/11506337.html

Python Multiprocessing: The Complete Guide https://superfastpython.com/multiprocessing-in-python/

Template for Python multiprocessing and multithreading https://gist.github.com/blaylockbk/8b469f2c79660ebdd18915202e0802a6
