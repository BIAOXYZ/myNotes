
# 1

Simplest async/await example possible in Python https://stackoverflow.com/questions/50757497/simplest-async-await-example-possible-in-python
- 【[:star:][`*`]】 https://stackoverflow.com/questions/50757497/simplest-async-await-example-possible-in-python/53420574#53420574
  * > To answer your questions, I will provide 3 different solutions to the same problem.
  * > **Case 1: just normal Python**
    ```py
    import time
    
    def sleep():
        print(f'Time: {time.time() - start:.2f}')
        time.sleep(1)
    
    def sum(name, numbers):
        total = 0
        for number in numbers:
            print(f'Task {name}: Computing {total}+{number}')
            sleep()
            total += number
        print(f'Task {name}: Sum = {total}\n')
    
    start = time.time()
    tasks = [
        sum("A", [1, 2]),
        sum("B", [1, 2, 3]),
    ]
    end = time.time()
    print(f'Time: {end-start:.2f} sec')
    ```
    > output:
    ```console
    Task A: Computing 0+1
    Time: 0.00
    Task A: Computing 1+2
    Time: 1.00
    Task A: Sum = 3
    
    Task B: Computing 0+1
    Time: 2.01
    Task B: Computing 1+2
    Time: 3.01
    Task B: Computing 3+3
    Time: 4.01
    Task B: Sum = 6
    
    Time: 5.02 sec
    ```
  * > **Case 2: async/await done wrong**
    ```py
    import asyncio
    import time
    
    async def sleep():
        print(f'Time: {time.time() - start:.2f}')
        time.sleep(1)
    
    async def sum(name, numbers):
        total = 0
        for number in numbers:
            print(f'Task {name}: Computing {total}+{number}')
            await sleep()
            total += number
        print(f'Task {name}: Sum = {total}\n')
    
    start = time.time()
    
    loop = asyncio.get_event_loop()
    tasks = [
        loop.create_task(sum("A", [1, 2])),
        loop.create_task(sum("B", [1, 2, 3])),
    ]
    loop.run_until_complete(asyncio.wait(tasks))
    loop.close()
    
    end = time.time()
    print(f'Time: {end-start:.2f} sec')
    ```
    > output:
    ```console
    Task A: Computing 0+1
    Time: 0.00
    Task A: Computing 1+2
    Time: 1.00
    Task A: Sum = 3
    
    Task B: Computing 0+1
    Time: 2.01
    Task B: Computing 1+2
    Time: 3.01
    Task B: Computing 3+3
    Time: 4.01
    Task B: Sum = 6
    
    Time: 5.01 sec
    ```
  * > **Case 3: async/await done right**
    >
    > Same as case 2 except the sleep function:
    ```py
    async def sleep():
        print(f'Time: {time.time() - start:.2f}')
        await asyncio.sleep(1)
    ```
    > output:
    ```console
    Task A: Computing 0+1
    Time: 0.00
    Task B: Computing 0+1
    Time: 0.00
    Task A: Computing 1+2
    Time: 1.00
    Task B: Computing 1+2
    Time: 1.00
    Task A: Sum = 3
    
    Task B: Computing 3+3
    Time: 2.00
    Task B: Sum = 6
    
    Time: 3.01 sec
    ```
  * > Case 1 and case 2 give the same **5 seconds**, whereas case 3 just **3 seconds**. So the `async`/`await` done right is faster.
  * > The reason for the difference is within the implementation of `sleep` function.
    ```py
    # case 1
    def sleep():
        ...
        time.sleep(1)
    
    # case 2
    async def sleep():
        ...
        time.sleep(1)
    
    # case 3
    async def sleep():
        ...
        await asyncio.sleep(1)
    ```
  * > In case 1 and case 2, they are the "same": they "sleep" without allowing others to use the resources. Whereas in case 3, it allows access to the resources when it is asleep.
  * > In case 2, we added `async` to the normal function. However the event loop will run it **without interruption**. Why? Because we didn't say where the loop is allowed to interrupt your function to run another task.
  * > In case 3, we told the event loop exactly where to interrupt the function to run another task. Where exactly? Right here!
    ```py
    await asyncio.sleep(1)
    ```
  * > More on this read [here](https://djangostars.com/blog/asynchronous-programming-in-python-asyncio/)
  * > Update 02/May/2020: Consider reading
    + > [A Hitchhikers Guide to Asynchronous Programming](https://github.com/crazyguitar/pysheeet/blob/master/docs/appendix/python-concurrent.rst)
    + > [Asyncio Futures and Coroutines](https://autobahn.readthedocs.io/en/latest/asynchronous-programming.html#asyncio-futures-and-coroutines)

# 2

Python 异步编程入门 https://www.ruanyifeng.com/blog/2019/11/python-asyncio.html
- > Python 的异步编程，其他人可能觉得很难，但是 JavaScript 程序员应该特别容易理解，因为两者的概念和语法类似。[JavaScript 的异步模型](https://es6.ruanyifeng.com/#docs/async)更简单直观，很适合作为学习 Python 异步的基础。
- > 本文解释 Python 的异步模块 `asyncio` 的概念和基本用法，并且演示如何通过 Python 脚本操作无头浏览器 [pyppeteer](https://github.com/miyakogi/pyppeteer) 。
- > **一、Python 异步编程的由来**
  * > 历史上，Python 并不支持专门的异步编程语法，因为不需要。
  * > 有了多线程（`threading`）和多进程（`multiprocessing`），就没必要一定支持异步了。如果一个线程（或进程）阻塞，新建其他线程（或进程）就可以了，程序不会卡死。
  * > 但是，多线程有"线程竞争"的问题，处理起来很复杂，还涉及加锁。对于简单的异步任务来说（比如与网页互动），写起来很麻烦。
  * > Python 3.4 引入了 `asyncio` 模块，增加了异步编程，跟 JavaScript 的 `async/await` 极为类似，大大方便了异步任务的处理。它受到了开发者的欢迎，成为从 Python 2 升级到 Python 3 的主要理由之一。
- > **二、`asyncio` 的设计**
  * > `asyncio` 模块最大特点就是，只存在一个线程，跟 JavaScript 一样。
  * > 由于只有一个线程，就不可能多个任务同时运行。`asyncio` 是"多任务合作"模式（`cooperative multitasking`），允许异步任务交出执行权给其他任务，等到其他任务完成，再收回执行权继续往下执行，这跟 JavaScript 也是一样的。
  * > 由于代码的执行权在多个任务之间交换，所以看上去好像多个任务同时运行，其实底层只有一个线程，多个任务分享运行时间。
  * > 表面上，这是一个不合理的设计，明明有多线程多进程的能力，为什么放着多余的 CPU 核心不用，而只用一个线程呢？但是就像前面说的，单线程简化了很多问题，使得代码逻辑变得简单，写法符合直觉。
  * > `asyncio` 模块在单线程上启动一个`事件循环`（`event loop`），时刻监听新进入循环的事件，加以处理，并不断重复这个过程，直到异步任务结束。事件循环的内部机制，可以参考 [JavaScript 的模型](https://wangdoc.com/javascript/async/general.html)，两者是一样的。
- > **三、asyncio API**
  * > 第一步，`import` 加载 `asyncio` 模块。
    ```py
    import asyncio
    ```
  * > 第二步，函数前面加上 `async` 关键字，就变成了 `async` 函数。这种函数最大特点是执行可以暂停，交出执行权。
    ```py
    async def main():
    ```
  * > 第三步，在 `async` 函数内部的异步任务前面，加上 `await` 命令。
    ```py
    await asyncio.sleep(1)
    ```
    > 上面代码中，`asyncio.sleep(1)` 方法可以生成一个异步任务，休眠1秒钟然后结束。
    > 
    > 执行引擎遇到 `await` 命令，就会在异步任务开始执行之后，暂停当前 `async` 函数的执行，把执行权交给其他任务。等到异步任务结束，再把执行权交回 `async` 函数，继续往下执行。
  * > 第四步，`async.run()` 方法加载 `async` 函数，启动事件循环。
    ```py
    asyncio.run(main())
    ```
    > 上面代码中，`asyncio.run()` 在事件循环上监听 `async` 函数main的执行。等到 `main` 执行完了，事件循环才会终止。

异步操作概述 https://wangdoc.com/javascript/async/general
- > **1.单线程模型**
  * > 单线程模型指的是，JavaScript 只在一个线程上运行。也就是说，JavaScript 同时只能执行一个任务，其他任务都必须在后面排队等待。
  * > 注意，JavaScript 只在一个线程上运行，不代表 JavaScript 引擎只有一个线程。事实上，JavaScript 引擎有多个线程，单个脚本只能在一个线程上运行（称为主线程），其他线程都是在后台配合。
  * > 如果排队是因为计算量大，CPU 忙不过来，倒也算了，但是很多时候 CPU 是闲着的，因为 IO 操作（输入输出）很慢（比如 Ajax 操作从网络读取数据），不得不等着结果出来，再往下执行。JavaScript 语言的设计者意识到，这时 CPU 完全可以不管 IO 操作，挂起处于等待中的任务，先运行排在后面的任务。等到 IO 操作返回了结果，再回过头，把挂起的任务继续执行下去。这种机制就是 JavaScript 内部采用的“`事件循环`”机制（`Event Loop`）。
