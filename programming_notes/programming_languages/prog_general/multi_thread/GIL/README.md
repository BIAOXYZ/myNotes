
Python的GIL是什么鬼，多线程性能究竟如何 http://cenalulu.github.io/python/gil-in-python/
- > **当前GIL设计的缺陷**
  * > PS：当然这种实现方式是原始而丑陋的，Python的每个版本中也在逐渐改进GIL和线程调度之间的互动关系。例如先尝试持有GIL在做线程上下文切换，在IO等待时释放GIL等尝试。但是无法改变的是GIL的存在使得操作系统线程调度的这个本来就昂贵的操作变得更奢侈了。 [关于GIL影响的扩展阅读](http://www.dabeaz.com/GIL/)
- > **如何避免受到GIL的影响**
  * > **用`multiprocessing`替代`Thread`**
    + > `multiprocessing`库的出现很大程度上是为了弥补thread库因为GIL而低效的缺陷。它完整的复制了一套thread所提供的接口方便迁移。唯一的不同就是它使用了多进程而不是多线程。每个进程有自己的独立的GIL，因此也不会出现进程之间的GIL争抢。
    + > 当然`multiprocessing`也不是万能良药。它的引入会增加程序实现时线程间数据通讯和同步的困难。就拿计数器来举例子，如果我们要多个线程累加同一个变量，对于thread来说，申明一个`global`变量，用`thread.Lock`的context包裹住三行就搞定了。而`multiprocessing`由于进程之间无法看到对方的数据，只能通过在主线程申明一个`Queue`，put再get或者用share memory的方法。这个额外的实现成本使得本来就非常痛苦的多线程程序编码，变得更加痛苦了。具体难点在哪有兴趣的读者可以扩展阅读[这篇文章](http://www.jeffknupp.com/blog/2013/06/30/pythons-hardest-problem-revisited/)
      >> //notes：链接里的文章地址改了：https://jeffknupp.com/blog/2013/06/30/pythons-hardest-problem-revisited/
  * > **用其他解析器**

Understanding the Python GIL http://www.dabeaz.com/GIL/
- Inside the Python GIL http://www.dabeaz.com/python/GIL.pdf

What Is the Python Global Interpreter Lock (GIL)? https://realpython.com/python-gil/
>> //notes：笔记参加realpython目录里相应的部分。
