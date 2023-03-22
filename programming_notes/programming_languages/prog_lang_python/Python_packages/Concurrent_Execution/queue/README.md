
# 官方

queue — A synchronized queue class https://docs.python.org/3/library/queue.html || queue --- 一个同步的队列类 https://docs.python.org/zh-cn/3/library/queue.html
- > 如何等待排队的任务被完成的示例：
  ```py
  import threading
  import queue

  q = queue.Queue()

  def worker():
      while True:
          item = q.get()
          print(f'Working on {item}')
          print(f'Finished {item}')
          q.task_done()

  # Turn-on the worker thread.
  threading.Thread(target=worker, daemon=True).start()

  # Send thirty task requests to the worker.
  for item in range(5):
      q.put(item)

  # Block until all tasks are done.
  q.join()
  print('All work completed')
  ```
  ```console
  Working on 0
  Finished 0
  Working on 1
  Finished 1
  Working on 2
  Finished 2
  Working on 3
  Finished 3
  Working on 4
  Finished 4
  All work completed
  ```

# 其他

`12. 使用 queue 进行线程通信` https://python-parallel-programmning-cookbook.readthedocs.io/zh_CN/latest/chapter2/12_Thread_communication_using_a_queue.html

Queue in Python https://www.geeksforgeeks.org/queue-in-python/
- > Queue in Python can be implemented by the following ways:
  ```console
  list
  collections.deque
  queue.Queue
  ```

Stack and Queue in Python using queue Module https://www.geeksforgeeks.org/stack-queue-python-using-module-queue/

queue https://www.liujiangblog.com/course/python/59
- > Python提供了很多关于队列的类，其中：
  * > Class `multiprocessing.Queue` 是用于多进程的队列类（不要和多线程搞混了）
  * > `collections.deque` 则是一种可选择的队列替代方案，它提供了快速的原子级别的 `append()` 和 `popleft()` 方法，但是不提供锁的能力。

第50天： Python Queue 进阶用法 http://www.ityouknow.com/python/2019/11/06/python-queue02-050.html
