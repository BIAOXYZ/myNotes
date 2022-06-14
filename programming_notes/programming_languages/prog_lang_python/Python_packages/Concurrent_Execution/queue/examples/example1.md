
# 1

第29天：Python queue 模块详解 http://www.ityouknow.com/python/2019/10/10/python-queue-029.html

## 个人实战文章里的例子（因为中文注释的原因，加了第一行识别 UTF8 编码）

```py
# -*- coding: utf-8 -*- 

from queue import Queue
import random
import threading
import time

#生产者线程
class Producer(threading.Thread):
    def __init__(self, t_name, queue):
        threading.Thread.__init__(self, name=t_name)
        self.data=queue
    def run(self):
        for i in range(5):
            print ("%s: %s is producing %d to the queue!" %(time.ctime(), self.getName(), i))
            self.data.put(i)  # 将生产的数据放入队列
            time.sleep(random.randrange(10)/5)
        print ("%s: %s finished!" %(time.ctime(), self.getName()))

#消费者线程
class Consumer(threading.Thread):
    def __init__(self, t_name, queue):
        threading.Thread.__init__(self, name=t_name)
        self.data=queue
    def run(self):
        for i in range(5):
            val = self.data.get()  # 拿出已经生产好的数据
            print ("%s: %s is consuming. %d in the queue is consumed!" %(time.ctime(), self.getName(), val))
            time.sleep(random.randrange(5))
            self.data.task_done() # 告诉队列有关这个数据的任务已经处理完成
        print ("%s: %s finished!" %(time.ctime(), self.getName()))

#主线程
def main():
    queue = Queue()
    producer = Producer('Pro.', queue)
    consumer = Consumer('Con.', queue)
    producer.start()
    consumer.start()
    queue.join()  # 阻塞，直到生产者生产的数据全都被消费掉
    producer.join() # 等待生产者线程结束
    consumer.join() # 等待消费者线程结束
    print ('All threads terminate!')
 
if __name__ == '__main__':
    main()
```
```console
Tue Jun 14 02:29:21 2022: Pro. is producing 0 to the queue!
Tue Jun 14 02:29:21 2022: Con. is consuming. 0 in the queue is consumed!
Tue Jun 14 02:29:22 2022: Pro. is producing 1 to the queue!
Tue Jun 14 02:29:22 2022: Pro. is producing 2 to the queue!
Tue Jun 14 02:29:22 2022: Con. is consuming. 1 in the queue is consumed!
Tue Jun 14 02:29:24 2022: Pro. is producing 3 to the queue!
Tue Jun 14 02:29:25 2022: Pro. is producing 4 to the queue!
Tue Jun 14 02:29:25 2022: Pro. finished!
Tue Jun 14 02:29:25 2022: Con. is consuming. 2 in the queue is consumed!
Tue Jun 14 02:29:26 2022: Con. is consuming. 3 in the queue is consumed!
Tue Jun 14 02:29:26 2022: Con. is consuming. 4 in the queue is consumed!
Tue Jun 14 02:29:29 2022: Con. finished!
All threads terminate!
```
```console
Tue Jun 14 02:38:02 2022: Pro. is producing 0 to the queue!
Tue Jun 14 02:38:02 2022: Con. is consuming. 0 in the queue is consumed!
Tue Jun 14 02:38:03 2022: Pro. is producing 1 to the queue!
Tue Jun 14 02:38:03 2022: Con. is consuming. 1 in the queue is consumed!
Tue Jun 14 02:38:04 2022: Pro. is producing 2 to the queue!
Tue Jun 14 02:38:04 2022: Con. is consuming. 2 in the queue is consumed!
Tue Jun 14 02:38:05 2022: Pro. is producing 3 to the queue!
Tue Jun 14 02:38:06 2022: Pro. is producing 4 to the queue!
Tue Jun 14 02:38:06 2022: Pro. finished!
Tue Jun 14 02:38:08 2022: Con. is consuming. 3 in the queue is consumed!
Tue Jun 14 02:38:10 2022: Con. is consuming. 4 in the queue is consumed!
Tue Jun 14 02:38:11 2022: Con. finished!
All threads terminate!
```

# 2

queue https://www.liujiangblog.com/course/python/59

## 个人实战文章里的例子

```py
# 这个改编了文章里的例子，不完全一样。

import queue
q = queue.Queue(5)
q.put(1)
q.put(2)
q.put(3)
print(123)
q.get()  # 1
q.get()  # 2
q.get()  # 3
print("Will start to block")
q.get()  # 阻塞了
print(456)  # 456是不会print出来的，因为第四个 get 操作阻塞了。
```
```console
123
Will start to block

```

```py
#!/usr/bin/env python
# -*- coding:utf-8 -*-
import time
import queue
import threading


def worker(i):
    while True:
        item = q.get()
        if item is None:
            print("线程%s发现了一个None,可以休息了^-^" % i)
            break
        # do_work(item)做具体的工作
        time.sleep(0.5)
        print("线程%s将任务<%s>完成了！" % (i, item))
        # 做完后发出任务完成信号，然后继续下一个任务
        q.task_done()


if __name__ == '__main__':
    num_of_threads = 5

    source = [i for i in range(1, 21)]  # 模拟20个任务

    # 创建一个FIFO队列对象，不设置上限
    q = queue.Queue()
    # 创建一个线程池
    threads = []
    # 创建指定个数的工作线程，并讲他们放到线程池threads中
    for i in range(1, num_of_threads+1):
        t = threading.Thread(target=worker, args=(i,))
        threads.append(t)
        t.start()

    # 将任务源里的任务逐个放入队列
    for item in source:
        time.sleep(0.5)     # 每隔0.5秒发布一个新任务
        q.put(item)

    # 阻塞队列直到队列里的任务都完成了
    q.join()
    print("-----工作都完成了-----")
    # 停止工作线程
    for i in range(num_of_threads):
        q.put(None)
    for t in threads:
        t.join()
    print(threads)
```
```console
线程1将任务<1>完成了！
线程2将任务<2>完成了！
线程3将任务<3>完成了！
线程4将任务<4>完成了！
线程5将任务<5>完成了！
线程1将任务<6>完成了！
线程2将任务<7>完成了！
线程3将任务<8>完成了！
线程4将任务<9>完成了！
线程5将任务<10>完成了！
线程1将任务<11>完成了！
线程2将任务<12>完成了！
线程3将任务<13>完成了！
线程4将任务<14>完成了！
线程5将任务<15>完成了！
线程1将任务<16>完成了！
线程2将任务<17>完成了！
线程3将任务<18>完成了！
线程4将任务<19>完成了！
线程5将任务<20>完成了！
-----工作都完成了-----
线程1发现了一个None,可以休息了^-^
线程2发现了��个None,可以休息了^-^
线程4发现了一个None,可以休息了^-^
线程3发现了一个None,可以休息了^-^
线程5发现了一个None,可以休息了^-^
[<Thread(Thread-1, stopped 140188453762816)>, <Thread(Thread-2, stopped 140188445370112)>, <Thread(Thread-3, stopped 140188436977408)>, <Thread(Thread-4, stopped 140188428584704)>, <Thread(Thread-5, stopped 140188420192000)>]
```
```console
线程1将任务<1>完成了！
线程1将任务<2>完成了！
线程3将任务<3>完成了！
线程4将任务<4>完成了！
线程5将任务<5>完成了！
线程5将任务<6>完成了！
线程1将任务<7>完成了！
线程3将任务<8>完成了！
线程4将任务<9>完成了！
线程2将任务<10>完成了！
线程5将任务<11>完成了！
线程1将任务<12>完成了！
线程3将任务<13>完成了！
线程4将任务<14>完成了！
线程2将任务<15>完成了！
线程5将任务<16>完成了！
线程1将任务<17>完成了！
线程3将任务<18>完成了！
线程4将任务<19>完成了！
线程2将任务<20>完成了！
-----工作都完成了-----
线程2发现了一个None,可以休息了^-^
线程4发现了��个None,可以休息了^-^
线程5发现了一个None,可以休息了^-^
线程3发现了一个None,可以休息了^-^
线程1发现了一个None,可以休息了^-^
[<Thread(Thread-1, stopped 139844488177408)>, <Thread(Thread-2, stopped 139844479784704)>, <Thread(Thread-3, stopped 139844403590912)>, <Thread(Thread-4, stopped 139844395198208)>, <Thread(Thread-5, stopped 139844386805504)>]
```
