
# 1

【[:star:][`*`]】 【加速】multiprocessing多线程、多进程、并行、numba https://www.guofei.site/2021/02/13/python_speedup.html
- > **前言**
  * > 多线程。
    + > 推荐使用 `from multiprocessing.dummy import Pool as ThreadPool`
    + > python 还提供了2个多线程接口 `thread` 提供底层接口。`threading` 提供高等级接口。）
    + > 一个进程中启动多个线程
    + > 由于Python中使用了全局解释锁GIL，导致Python中的多线程并不是真并行，而是“交替执行” 。
    + > ***所以 Python 多线程适合IO密集型任务，而不适合计算密集型任务***。
    + > 甚至在多核CPU上用多线程执行计算密集任务，由于 GIL 的存在，会导致多核争抢1个GIL，让任务比普通的更慢。
  * > 多进程（Python 提供 `mutliprocess` 作为多进程接口。）
    + > 推荐使用 `from multiprocessing import Pool`
    + > 由于Python中GIL的原因，对于计算密集型任务，Python下比较好的并行方式是使用多进程，这样可以非常有效的使用CPU资源。
    + > 同一时间执行的进程数量取决你电脑的CPU核心数。
  * > 测试函数：

python多进程总结 https://www.cnblogs.com/fengf233/p/11506337.html
