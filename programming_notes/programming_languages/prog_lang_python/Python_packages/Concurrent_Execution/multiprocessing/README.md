
# 官方

multiprocessing --- 基于进程的并行 https://docs.python.org/zh-cn/3/library/multiprocessing.html

# 视频

Python multiprocessing 5 进程池 pool (多进程 多核运算 教学教程tutorial) https://www.youtube.com/watch?v=w7SG9hhhwvI

# 其他

一篇文章搞定Python多进程(全) - 南山南的文章 - 知乎 https://zhuanlan.zhihu.com/p/64702600
- 一篇文章搞懂Python多线程简单实现和GIL https://mp.weixin.qq.com/s/Hgp-x-T3ss4IiVk2_4VUrA
- 一篇文章理清Python多线程同步锁，死锁和递归锁 https://mp.weixin.qq.com/s/RZSBe2MG9tsbUVZLHxK9NA
- 一篇文章理清Python多线程之同步条件，信号量和队列 https://mp.weixin.qq.com/s/vKsNbDZnvg6LHWVA-AOIMA

在Python中优雅地用多进程 - 曾伊言的文章 - 知乎 https://zhuanlan.zhihu.com/p/340657122

多进程 https://www.liaoxuefeng.com/wiki/1016959663602400/1017628290184064

多进程multiprocess https://www.liujiangblog.com/course/python/82

Python Multiprocessing Example https://www.digitalocean.com/community/tutorials/python-multiprocessing-example

Python并行编程(Multiprocessing)与实例 http://zhaoxuhui.top/blog/2018/07/19/PythonMultiprocessing.html
- > **3.最优并行进程数**
  * > 这便很明显地反应了进程数与效率之间的关系，随着进程数的增加，耗时急剧下降，但随着进程数的持续增加，效率的提升就不是这么明显了。甚至当进程数大于某一数值后，随着进程数的增加，耗时反而增加了。出现这种情况的原因在于，当进程数过多后，进程间通信将变得更加复杂，相比于进程数增加带来的效率提升，其增加带来的副作用(进程调度、通信等复杂操作)更大了，所以导致了效率的下降。
- > **4.最优进程数自动选择**

Python多进程详解 - 叶底藏花的文章 - 知乎 https://zhuanlan.zhihu.com/p/521283266

# `multiprocessing.Queue`

【python】详解multiprocessing多进程-Queue、Pipe进程间通信（三） https://blog.csdn.net/brucewong0516/article/details/85796073
- > **Queue 用来在多个进程间通信。Queue 有两个方法，get 和 put：
  * > put：放数据，Queue.put( )默认有block=True和timeout两个参数。当block=True时，写入是阻塞式的，阻塞时间由timeout确定。当队列q被（其他线程）写满后，这段代码就会阻塞，直至其他线程取走数据。Queue.put（）方法加上 block=False 的参数，即可解决这个隐蔽的问题。但要注意，非阻塞方式写队列，当队列满时会抛出 exception Queue.Full 的异常
  * > get：取数据(默认阻塞),Queue.get([block[, timeout]])获取队列，timeout等待时间

Multiprocessing Queue in Python https://superfastpython.com/multiprocessing-queue-in-python/

How to use multiprocessing queue in Python? https://stackoverflow.com/questions/11515944/how-to-use-multiprocessing-queue-in-python

# 问题

## `multiprocessing` 里无法使用 lambda 函数或者非 “top-module level” 的函数

AttributeError: Can't pickle local object in Multiprocessing https://stackoverflow.com/questions/72766345/attributeerror-cant-pickle-local-object-in-multiprocessing
- https://stackoverflow.com/questions/72766345/attributeerror-cant-pickle-local-object-in-multiprocessing/72776044#72776044

`AttributeError: Can't pickle local object '<locals>.<lambda>'` https://stackoverflow.com/questions/72339545/attributeerror-cant-pickle-local-object-locals-lambda 

### 解决

Ways to Solve Can’t Pickle local object Error https://www.pythonpool.com/cant-pickle-local-object/
- > **Example 2: Attribute error while multiprocessing – can’t pickle local objects**
  ```py
  import multiprocessing
  def function():
      a="string"
      def fun1():
          print(a)
      var1=multiprocessing.Process(target=fun1,args=(a))
      if __name__ == "__main__":
          var1.start()
          var1.join()
  function()
  print("Program finished")
  ```
  > In this program, we are going to see how to rectify the attribute error while multiprocessing. Import multiprocessing. Create a function. We are trying to process the function by declaring it as a local object. But it shows an error. So that we are trying to pickle an object as a global object.
- > **Example 2: Solving Attribute Error**
  ```py
  import multiprocessing
  def function():
      global fun1
      a="string"
      def fun1():
          print(a)
      var1=multiprocessing.Process(target=fun1,args=(a))
      if __name__ == "__main__":
          var1.start()
          var1.join()
  function()
  print("Program finished")
  ```
  > Now we are declaring it as global so that we can pickle objects easily. Now the program will run properly without any errors.
  >> //notes：所以（还是想写成闭包函数的样子的话）其实定义成 `global` 的就行- -

AttributeError: Can't pickle local object 解决办法 https://blog.csdn.net/qq_39314099/article/details/83822593
