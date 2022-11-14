
# 官方

asyncio --- 异步 I/O https://docs.python.org/zh-cn/3/library/asyncio.html
- 协程与任务 https://docs.python.org/zh-cn/3/library/asyncio-task.html

# 视频

Python Asynchronous Programming - AsyncIO & Async/Await https://www.youtube.com/watch?v=t5Bo1Je9EmE

# 其他

Awesome asyncio https://github.com/timofurrer/awesome-asyncio

Getting Started With Async Features in Python https://realpython.com/python-async-features/

~~Async IO in Python: A Complete Walkthrough https://realpython.com/async-io-python/~~  【//已转移】

从0到1，Python异步编程的演进之路 - tonnie的文章 - 知乎 https://zhuanlan.zhihu.com/p/25228075

Python Async/Await入门指南 - tonnie的文章 - 知乎 https://zhuanlan.zhihu.com/p/27258289
- > 本文将会讲述Python 3.5之后出现的 `async`/`await` 的使用方法，以及它们的一些使用目的，如果错误，欢迎指正。
- > 昨天看到David Beazley在16年的一个演讲：[Fear and Awaiting in Async](https://www.youtube.com/watch?v=E-1Y4kSsAFc)，给了我不少的感悟和启发，于是想梳理下自己的思路，所以有了以下这篇文章。
- > Python在3.5版本中引入了关于协程的语法糖 `async` 和 `await`，关于协程的概念可以先看我在[上一篇文章](https://zhuanlan.zhihu.com/p/25228075)提到的内容。
- 回复里的：
  * > 完全能理解你的意思，python这个async/await的所有解释和说明，你就在网上搜吧，千篇一侓的都是LZ说的这些玩意儿，总结一下就是：一顿介绍猛如虎，一到实战二百五！什么意思呢，就是说了一堆，到实际用的时候发现根本一点边也贴不着！所有的介绍都是用asyncio.sleep(x)来模拟，这个东西是asyncio库里的，而不是实际中如你说的各种实际操作，如正常的打开文件写文件查数据库等，如果LZ说的这些，你在实际中套用真时的如上面说的文件操作数据库操作，你会发现，套用的时候要么出错，要么就一个一个的去执行，根本就不会像yield那样的跳出，就像你写了func1 func2 func3，最后都是按顺序执行的，所以能搜这些知识的人不是看理论和解释，能去搜这些的人，相信理论都懂了，而是想看真正的生产操作。说人话和很直白的说就像Rust中的await async那样：就是想自己在生产函数中能有个清楚的指令如pending，可以让线程切换走，然后有一个像complete的指令告诉循环本次被挂起的任务已经结束了，可以被再一次轮循而得到结果了：
    ```
    def 自己的生产函数:
    这里是初始化的操作
    pending告诉线程 我让出要挂起 去IO操作
    IO操作过了10秒中。。。IO结束 发出complete 请求再次轮循
    ```
    > 就像上面这样，但没有一篇文件是类似这样的，都是说的和官方文档一样的东西，然后再扒一点源代码说说理论，看这些真的有点隔靴挠痒啊，看了一堆，最后一点用不上！
  * > 你这个问题我去年也经常疑惑，现在已经完全搞清楚了，可以告诉你。要在生产实际操作中使用异步操作代替asyncio.sleep(x)，那必须首先需要一个异步库！比如你连接mysql，那就需要一个异步的连接mysql的库！像pymysql这种同步的库是不能用的！异步库怎么来呢？牛人可以自己写，但是像我们这样的还是用现成的轮子，比如已经有牛人写了aiomysql。其他的io操作，比如http请求，可以用aiohttp，文件读写，可以用aiofile。至于你说的ssh远程连接，目前有netdev模块，去年刚出来的，通用性还不是很好。一句话，你所熟悉的同步模块（比如paramiko，requests）等是不能直接支持异步操作的，得把这些同步模块的底层完全改写才可以！

异步IO https://www.liaoxuefeng.com/wiki/1016959663602400/1017959540289152
- 协程 https://www.liaoxuefeng.com/wiki/1016959663602400/1017968846697824
- asyncio https://www.liaoxuefeng.com/wiki/1016959663602400/1017970488768640
- async/await https://www.liaoxuefeng.com/wiki/1016959663602400/1048430311230688
- aiohttp https://www.liaoxuefeng.com/wiki/1016959663602400/1017985577429536
