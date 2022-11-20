
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

【[:star:][`*`]】 Python 异步编程入门 https://www.ruanyifeng.com/blog/2019/11/python-asyncio.html
- > Python 的异步编程，其他人可能觉得很难，但是 JavaScript 程序员应该特别容易理解，因为两者的概念和语法类似。[JavaScript 的异步模型](https://es6.ruanyifeng.com/#docs/async)更简单直观，很适合作为学习 Python 异步的基础。
- > 本文解释 Python 的异步模块 `asyncio` 的概念和基本用法，并且演示如何通过 Python 脚本操作无头浏览器 [pyppeteer](https://github.com/miyakogi/pyppeteer) 。
- > **一、Python 异步编程的由来**
  * > 历史上，Python 并不支持专门的异步编程语法，因为不需要。
  * > ***有了多线程（`threading`）和多进程（`multiprocessing`），就没必要一定支持异步了***。如果一个线程（或进程）阻塞，新建其他线程（或进程）就可以了，程序不会卡死。
  * > ***但是，多线程有"线程竞争"的问题，处理起来很复杂，还涉及加锁***。对于简单的异步任务来说（比如与网页互动），写起来很麻烦。
  * > Python 3.4 引入了 `asyncio` 模块，增加了异步编程，跟 JavaScript 的 `async/await` 极为类似，大大方便了异步任务的处理。它受到了开发者的欢迎，成为从 Python 2 升级到 Python 3 的主要理由之一。
- > **二、`asyncio` 的设计**
  * > `asyncio` 模块最大特点就是，***<ins>只存在一个线程</ins>，跟 JavaScript 一样***。
  * > 由于只有一个线程，就不可能多个任务同时运行。`asyncio` 是"多任务合作"模式（`cooperative multitasking`），***允许异步任务交出执行权给其他任务，等到其他任务完成，再收回执行权继续往下执行，这跟 JavaScript 也是一样的***。
  * > 由于代码的执行权在多个任务之间交换，所以看上去好像多个任务同时运行，***其实底层只有一个线程，多个任务分享运行时间***。
  * > 表面上，这是一个不合理的设计，明明有多线程多进程的能力，为什么放着多余的 CPU 核心不用，而只用一个线程呢？但是就像前面说的，单线程简化了很多问题，使得代码逻辑变得简单，写法符合直觉。
  * > `asyncio` 模块在单线程上启动一个`事件循环`（`event loop`），时刻监听新进入循环的事件，加以处理，并不断重复这个过程，直到异步任务结束。***事件循环的内部机制，可以参考 [JavaScript 的模型](https://wangdoc.com/javascript/async/general.html)，两者是一样的***。
- > **三、`asyncio` API**
  * > 下面介绍 `asyncio` 模块最主要的几个API。注意，必须使用 Python 3.7 或更高版本，早期的语法已经变了。
  * > 第一步，`import` 加载 `asyncio` 模块。
    ```py
    import asyncio
    ```
  * > 第二步，函数前面加上 `async` 关键字，就变成了 `async` 函数。***这种函数最大特点是执行可以暂停，交出执行权***。
    ```py
    async def main():
    ```
  * > 第三步，在 `async` 函数内部的异步任务前面，加上 `await` 命令。
    ```py
    await asyncio.sleep(1)
    ```
    > 上面代码中，`asyncio.sleep(1)` 方法可以生成一个异步任务，休眠1秒钟然后结束。
    > 
    > ***执行引擎遇到 `await` 命令，就会在异步任务开始执行之后，暂停当前 `async` 函数的执行，把执行权交给其他任务***。等到异步任务结束，再把执行权交回 `async` 函数，继续往下执行。
  * > 第四步，`async.run()` 方法加载 `async` 函数，启动事件循环。
    ```py
    asyncio.run(main())
    ```
    > 上面代码中，`asyncio.run()` 在事件循环上监听 `async` 函数 `main` 的执行。***等到 `main` 执行完了，事件循环才会终止***。
- > **四、`async` 函数的示例**
  * > 下面是 `async` 函数的例子，新建一个脚本 `async.py`，代码如下。
    ```py
    #!/usr/bin/env python3
    # async.py

    import asyncio

    async def count():
        print("One")
        await asyncio.sleep(1)
        print("Two")

    async def main():
        await asyncio.gather(count(), count(), count())

    asyncio.run(main())
    ```
    > 上面脚本中，在 `async` 函数 `main` 的里面，***`asyncio.gather()` 方法将多个异步任务（三个 `count()`）包装成一个新的异步任务，<ins>必须等到内部的多个异步任务都执行结束，这个新的异步任务才会结束</ins>***。
  * > 脚本的运行结果如下。
    ```sh
    $ python3 async.py
    One
    One
    One
    Two
    Two
    Two
    ```
    > 上面运行结果的原因是，三个 count() 依次执行，打印完 One，就休眠1秒钟，把执行权交给下一个 count()，所以先连续打印出三个 One。等到1秒钟休眠结束，执行权重新交回第一个 count()，开始执行 `await` 命令下一行的语句，所以会接着打印出三个 Two。***脚本总的运行时间是1秒***。
  * > 作为对比，下面是这个例子的同步版本 `sync.py`。
    ```py
    #!/usr/bin/env python3
    # sync.py

    import time

    def count():
        print("One")
        time.sleep(1)
        print("Two")

    def main():
        for _ in range(3):
            count()

    main()
    ```
    > 上面脚本的运行结果如下。
    ```sh
    $ python3 sync.py 
    One
    Two
    One
    Two
    One
    Two
    ```
    > 上面运行结果的原因是，三个 count() 都是同步执行，必须等到前一个执行完，才能执行后一个。***脚本总的运行时间是3秒***。
- > **五、实例：`pyppeteer` 模块**
  * > 最后是一个异步编程的真实例子：操作无头浏览器。异步编程对代码的简化，在这个例子体现得淋漓尽致。
  * > 我们需要用到 [pyppeteer 模块](https://pypi.org/project/pyppeteer/)，它是无头浏览器 Puppeteer 的 Python 移植，API 跟 JavaScript 版本基本一致。下面是安装命令。
    ```py
    $ python3 -m pip install pyppeteer
    ```
  * > 然后，写一个网页截图脚本 `screenshot.py`。
    ```py
    #!/usr/bin/env python3
    # screenshot.py

    import asyncio
    from pyppeteer import launch

    async def main():
        browser = await launch()
        page = await browser.newPage()
        await page.goto('http://example.com')
        await page.screenshot({'path': 'example.png'})
        await browser.close()

    asyncio.run(main())
    ```
    > 上面代码中，启动浏览器（`launch`）、打开新 Tab（`newPage()`）、访问网址（`page.goto()`）、截图（`page.screenshot()`）、关闭浏览器（`browser.close()`），这一系列操作都是异步任务，使用 `await` 命令写起来非常自然简单。
  * > 执行这个脚本，当前目录下就会生成截图文件 `example.png`。
    ```sh
    $ python3 screenshot.py
    ```
    > 如果脚本执行时报错 `No usable sandbox!`，可以参考[这里](https://github.com/GoogleChrome/puppeteer/blob/master/docs/troubleshooting.md#setting-up-chrome-linux-sandbox)。另外，第一次执行这个脚本，会下载安装 Puppeteer，可能需要等待较长时间，但是此后的执行就会很快。
  * > Pyppeteer 的[官网](https://miyakogi.github.io/pyppeteer/)还有其他实例，比如向网页注入 JavaScript 代码，大家可以自己试玩。
- > **六、参考链接**
  * > [Async IO in Python: A Complete Walkthrough](https://realpython.com/async-io-python/), Brad Solomon
- 回复里的：
  * > screenshot.py 这个例子中，虽然五个步骤可以异步处理，但它们之间明显有前后关系。也可以吗？
    >> 五个步骤会安顺序执行，上一个执行完了在执行下一个，这里没有调用 `asyncio.gather` 方法，所以不会节省时间
    >>> 正是因为有前后关系，才用到 `await`
    >>>> 这个栗子说明了什么呢？ 比起同步线程有任何优势吗？ 还是仅仅为了说明语法。
    >>>>> ***本来也觉得没什么卵用，直到我去掉 `async` 和 `await` 后，一运行就报错了***。
  * > 主要要自己分辨哪些方法、函数能用 `asyncio`，哪些不能，比如 `requests` 就不能用原生 `asyncio`，老司机用起来才会轻车熟路一点
    >> 异步网络请求可以用 `aiohttp` 这个库
  * > `asyncio 模块最大特点就是，只存在一个线程` -- 这里确切地说，只有一个 `eventloop` 线程，`threading.Thread` 还是能正常使用的。
  * > 其实打印1和2的例子举得并不好，本质的区别并不是`async def`和`普通def`，真正导致运行时间不同的原因是运行方式。并行执行一个普通的count函数也可以实现one one one two two two的效果。

异步操作概述 https://wangdoc.com/javascript/async/general
- > **1.单线程模型**
  * > 单线程模型指的是，JavaScript 只在一个线程上运行。也就是说，***JavaScript 同时只能执行一个任务，其他任务都必须在后面排队等待***。
  * > 注意，JavaScript 只在一个线程上运行，不代表 JavaScript 引擎只有一个线程。事实上，JavaScript 引擎有多个线程，单个脚本只能在一个线程上运行（称为主线程），其他线程都是在后台配合。
  * > 如果排队是因为计算量大，CPU 忙不过来，倒也算了，但是很多时候 CPU 是闲着的，因为 IO 操作（输入输出）很慢（比如 Ajax 操作从网络读取数据），不得不等着结果出来，再往下执行。JavaScript 语言的设计者意识到，这时 CPU 完全可以不管 IO 操作，挂起处于等待中的任务，先运行排在后面的任务。等到 IO 操作返回了结果，再回过头，把挂起的任务继续执行下去。***这种机制就是 JavaScript 内部采用的“`事件循环`”机制（`Event Loop`）***。
- > **2.同步任务和异步任务**
  * > 程序里面所有的任务，可以分成两类：同步任务（`synchronous`）和异步任务（`asynchronous`）。
  * > ***同步任务是那些没有被引擎挂起、在主线程上排队执行的任务。只有前一个任务执行完毕，才能执行后一个任务***。
  * > ***异步任务是那些被引擎放在一边，<ins>不进入主线程、而进入任务队列的任务</ins>***。只有引擎认为某个异步任务可以执行了（比如 Ajax 操作从服务器得到了结果），该任务（采用回调函数的形式）才会进入主线程执行。***<ins>排在异步任务后面的代码，不用等待异步任务结束会马上运行，也就是说，异步任务不具有“堵塞”效应</ins>***。
  * > 举例来说，Ajax 操作可以当作同步任务处理，也可以当作异步任务处理，由开发者决定。如果是同步任务，主线程就等着 Ajax 操作返回结果，再往下执行；如果是异步任务，主线程在发出 Ajax 请求以后，就直接往下执行，等到 Ajax 操作有了结果，主线程再执行对应的回调函数。
- > **3.任务队列和事件循环**
  * > JavaScript 运行时，***除了一个正在运行的主线程，引擎还提供一个任务队列（task queue），里面是各种需要当前程序处理的异步任务***。（实际上，根据异步任务的类型，存在多个任务队列。为了方便理解，这里假设只存在一个队列。）
  * > 首先，主线程会去执行所有的同步任务。等到同步任务全部执行完，就会去看任务队列里面的异步任务。***如果满足条件，那么异步任务就重新进入主线程开始执行，这时它就变成同步任务了***。等到执行完，下一个异步任务再进入主线程开始执行。***一旦任务队列清空，程序就结束执行***。
  * > 异步任务的写法通常是`回调函数`。***一旦异步任务重新进入主线程，就会执行对应的回调函数。如果一个异步任务没有回调函数，就不会进入任务队列，也就是说，不会重新进入主线程，因为没有用回调函数指定下一步的操作***。
  * > ***JavaScript 引擎怎么知道异步任务有没有结果，能不能进入主线程呢***？答案就是引擎在不停地检查，一遍又一遍，只要同步任务执行完了，引擎就会去检查那些挂起来的异步任务，是不是可以进入主线程了。***这种循环检查的机制，就叫做事件循环（`Event Loop`）***。维基百科的定义是：“事件循环是一个程序结构，用于等待和发送消息和事件（a programming construct that waits for and dispatches events or messages in a program）”。
- > **4.异步操作的模式**
  * > 下面总结一下异步操作的几种模式。
  * > **4.1 回调函数**
  * > **4.2 事件监听**
    + > 另一种思路是采用事件驱动模式。异步任务的执行不取决于代码的顺序，而取决于某个事件是否发生。
  * > **4.3 发布/订阅**
- > **5.异步操作的流程控制**
  * > **5.1 串行执行**
  * > **5.2 并行执行**
  * > **5.3 并行与串行的结合**
