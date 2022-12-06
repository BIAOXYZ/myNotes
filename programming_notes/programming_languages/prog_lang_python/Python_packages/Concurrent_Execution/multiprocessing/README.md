
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
