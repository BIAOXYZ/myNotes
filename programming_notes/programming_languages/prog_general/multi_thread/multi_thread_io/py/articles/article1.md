


# 1

How to Speed-up File IO with Concurrency in Python https://superfastpython.com/concurrency-file-io/
- > **Speed-Up File IO With Concurrency**
  * > Each of processes, threads, and asyncio has a sweet spot.
    + > **Processes** are suited for CPU-bound tasks, but are limited to perhaps tens of tasks and overhead in sharing data between processes.
    + > **Threads** are suited to IO-bound tasks, but are limited to perhaps thousands of tasks.
    + > **AsyncIO** is suited to large-scale IO-bound tasks, e.g. perhaps tens of thousands of tasks, but are limited to a subset of non-blocking IO operations and require adopting the asynchronous programming paradigm.
- > **Concurrency for File IO**

python多线程飞速写入文件 https://blog.csdn.net/weixin_35757704/article/details/107175302
