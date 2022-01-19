
【[:ok:][:star:][`*`]】 深入理解Python中的GIL（全局解释器锁）。 - 蜗牛学苑的文章 - 知乎 https://zhuanlan.zhihu.com/p/75780308
- > **1. GIL是什么？**
  * > 首先来看看GIL究竟是什么。我们需要明确的一点是GIL并不是Python的特性，它是在实现Python解析器(CPython)时所引入的一个概念。就好比C++是一套语言（语法）标准，但是可以用不同的编译器来编译成可执行代码。有名的编译器例如GCC，INTEL C++，Visual C++等。Python也一样，同样一段代码可以通过CPython，PyPy，Psyco等不同的Python执行环境来执行。像其中的JPython就没有GIL。然而因为CPython是大部分环境下默认的Python执行环境。所以在很多人的概念里CPython就是Python，也就想当然的把GIL归结为Python语言的缺陷。所以这里要先明确一点：GIL并不是Python的特性，Python完全可以不依赖于GIL。
  * > 那么CPython实现中的GIL又是什么呢？GIL全称Global Interpreter Lock为了避免误导，我们还是来看一下官方给出的解释：`In CPython, the global interpreter lock, or GIL, is a mutex that prevents multiple native threads from executing Python bytecodes at once. This lock is necessary mainly because CPython’s memory management is not thread-safe. (However, since the GIL exists, other features have grown to depend on the guarantees that it enforces.)`
  * > 这看起来像一个Bug一般的防止多线程并发执行机器码的互斥锁(mutex)，究竟为什么会存在？
- > **2. GIL为什么会存在？**
  * > GIL的问题其实是由于近十几年来应用程序和操作系统逐步从多任务单核心演进到多任务多核心导致的 , 在一个古老的单核CPU上调度多个线程任务，大家相互共享一个全局锁，谁在CPU执行，谁就占有这把锁，***直到这个线程因为IO操作或者Timer Tick到期让出CPU***，没有在执行的线程就安静的等待着这把锁（除了等待之外，他们应该也无事可做）。下面这个图演示了一个***单核CPU的线程调度方式***：
  * > ![](https://pic4.zhimg.com/80/v2-55f25ae40ec5448d41e5bf2861d41227_1440w.jpg)
  * > 很明显，在一个现代多核心的处理器上，上面的模型就有很大优化空间了，原来只能等待的线程任务，现在可以在其它空闲的核心上调度并发执行。***由于古老GIL机制，如果线程2需要在CPU 2 上执行，它需要先等待在CPU 1 上执行的线程1释放GIL***（记住：GIL是全局的）。如果线程1是因为 I/O 阻塞让出的GIL，那么线程2必定拿到GIL。但如果线程1是因为timer ticks计数满100让出GIL，那么这个时候线程1和线程2公平竞争。但要命的是，在Python 2.x, 线程1不会动态的调整自身的优先级，所以很大概率下次被选中执行的还是线程1，在很多个这样的选举周期内，线程2只能安静的看着线程1拿着GIL在CPU 1上欢快的执行。
  * > ![](https://pic1.zhimg.com/80/v2-de0f7eefb6b3bece0d354fb782f4b564_1440w.jpg)
  * > 在稍微极端一点的情况下，比如线程1使用了while True在CPU 1 上执行，那就真是“一核有难，八核围观”了，如下图所示：
  * > ![](https://pic2.zhimg.com/80/v2-4fbbf725a0d52eb12109a4436ae1e69d_1440w.jpg)
  * > 接下来，我们用实际代码来看看GIL的存在对多线程运行的影响（此处使用循环模拟耗时操作）：
    ```py
    # coding: utf-8
    import threading, time
    
    def my_counter():
        i = 0
        for _ in range(100000000):
            i = i+1
        return True
    
    def main1():
        thread_ary = {}
        start_time = time.time()
        for tid in range(2):
            t = threading.Thread(target=my_counter)
            t.start()
            t.join()  # 第一次循环的时候join方法引起主线程阻塞，但第二个线程并没有启动，所以两个线程是顺序执行的
        print("单线程顺序执行total_time: {}".format(time.time() - start_time))
    
    def main2():
        thread_ary = {}
        start_time = time.time()
        for tid in range(2):
            t = threading.Thread(target=my_counter)
            t.start()
            thread_ary[tid] = t
        for i in range(2):
            thread_ary[i].join()  # 两个线程均已启动，所以两个线程是并发的
        print("并发执行total_time: {}".format(time.time() - start_time))
    
    if __name__ == "__main__":
        main1()
        main2()
    ```
    > 上面这段代码，在Python3上运行，不管是并发执行还是顺序执行，运行时间都差不多，这充分说明了GIL确实会在这种情况下对多线程程序的运行效率产生影响。***如果是在Python2上运行，则差距更明显***。
- > **3. GIL是否意味着线程安全**
  * > 有GIL并不意味着python一定是线程安全的，那什么时候安全，什么时候不安全，我们必须搞清楚。之前我们已经说过，***一个线程有两种情况下会释放全局解释器锁***，一种情况是***在该线程进入IO操作之前，会主动释放GIL***，另一种情况是***解释器不间断运行了1000字节码（Py2）或运行15毫秒（Py3）后，该线程也会放弃GIL***。既然一个线程可能随时会失去GIL，那么这就一定会涉及到线程安全的问题。GIL虽然从设计的出发点就是考虑到线程安全，但这种线程安全是粗粒度的线程安全，即不需要程序员自己对线程进行加锁处理（同理，所谓细粒度就是指程序员需要自行加、解锁来保证线程安全，典型代表是 Java , 而 CPthon 中是粗粒度的锁，即语言层面本身维护着一个全局的锁机制,用来保证线程安全）。那么什么时候需要加锁，什么时候不需要加锁，这个需要具体情况具体分析。下面我们就来针对每种可能的情况进行分析和总结。
  * > 首先来看第一种线程释放GIL的情况。假设现在线程A因为进入IO操作而主动释放了GIL，那么在这种情况下，由于线程A的IO操作等待时间不确定，那么等待的线程B一定会得到GIL锁，这种比较“礼貌的”情况我们一般称为“协同式多任务处理”，相当于大家按照协商好的规则来，线程是安全的，不需要额外加锁。
  * > 接下来，我们来看另外一种情况，即线程A是因为解释器不间断执行了1000字节码的指令或不间断运行了15毫秒而放弃了GIL，那么此时实际上线程A和线程B将同时竞争GIL锁。在同时竞争的情况下，实际上谁会竞争成功是不确定的一个结果，所以一般被称为“抢占式多任务处理”，这种情况下当然就看谁抢得厉害了。当然，在python3上由于对GIL做了优化，并且会动态调整线程的优先级，所以线程B的优先级会比较高，但仍然无法肯定线程B就一定会拿到GIL。那么在这种情况下，线程可能就会出现不安全的状态。针对这种纯计算的操作，我们用一段代码来演示下这种线程不安全的状态。代码如下：
    ```py
    # coding: utf-8
    import threading
    n = 0

    def add():
        global n
        for i in range(1000000):
            n = n + 1
    
    def sub():
        global n
        for i in range(1000000):
            n = n - 1
    
    if __name__ == "__main__":
        t1 = threading.Thread(target=add)
        t2 = threading.Thread(target=sub)
        t1.start()
        t2.start()
        t1.join()
        t2.join()
        print("n的值为:", n)
    ```
    > 上面的代码很简单，分别用线程1和线程2对全局变量n进行了1000000次的加和减操作。如果线程安全的话，那么最终的结果n应该还是为0。但实际上，我们运行之后，会发现这个n的值有时大有时小，完全不确定。这就是典型的多个线程操作同一个全局变量造成的线程不安全的问题。我们明白了这个问题，在这里我们只讨论产生问题的原因，在后面的文章中再来讨论如何通过加锁来解决这个问题。
  * > 接下来，我们从代码层面分析下产生这个问题的原因。在线程中，我们主要是执行了一个加法和减法的操作。为了方便说明问题，我们把函数最简化到一个加法函数和一个减法函数，来分析它们的字节码执行过程，来看看释放GIL锁是怎么引起这个问题的。演示代码如下：
    ```py
    # coding: utf-8
    import dis
    n = 0
    
    def add():
        global n
        n = n + 1
    print(dis.dis(add))
    
    def sub():
        global n
        n = n - 1
    print(dis.dis(sub))
    ```
    > `dis`模块中的`dis`方法可以***打印出一个函数对应的字节码执行过程***，所以非常方便我们进行分析。运行结果如下：![](https://pic4.zhimg.com/80/v2-cf2334fcfb58d394a1e99f73ea39851b_1440w.jpg)
    > 
    > 不管是加法还是减法运算，都会分为4步完成。以加法为例，第一步是`LOAD_GLOBAL`(加载全局变量n)，第二步`LOAD_CONST`(加载常量1)，第三步进行二进制的加法，第四步将计算结果存储到全局变量n中，加法计算结束。这四个指令如果能够保证被作为一个整体完整地运行，那么是不会产生问题的，但根据前面说的线程释放GIL的原则，那么很有可能在线程正在执行这四步中的任何一步的时候释放掉GIL而进入等待状态，这个时候发生的事情就比较有意思了。为了方便大家理解，我拿一种比较极端的情况来说明一下。比如我们在加法运算中，正准备执行第四步的时候，很不幸失去了GIL，进入等待状态（注意此时n值仍然为0）。减法运算的线程开始执行，它加载了全局变量n（值为0），并进行减法相关的计算，它也在执行第三步的时候失去了GIL，此时它进入等待状态，加法运算继续。上一次加法计算继续运行第4步，即把加法运算结果赋值给全局变量n，那么此时n的值为1。同样道理，减法操作拿回GIL时，它之前已经加载了为0的n的值，所以它继续操作到最后赋值那步时，n的值就为0-1=-1。换句话说，n的值要么为1，要么为-1，但我们期望的应该是0。这就造成了线程不安全的情形。最终，经过百万次这样不确定的加减操作，那么结果一定是不确定的。这就是引起这个问题的过程和原因。
  * > 接下来，我们还要解决另外一个问题，也就是既然GIL从粗粒度情况下存在线程不安全的可能性，那么是不是所有非IO操作引起的GIL释放都要加锁来解决线程安全的问题。这个问题同样要分情况，因为python跟其他线程自由的语言比如 Java 相比，它有很多操作是原子级的，针对原子级的操作，由于方法本身是单个字节码，所以线程没有办法在调用期间放弃GIL。典型的例子比如`sort`方法，我们同样可以看看这种原子级的操作在python的字节码中是什么样子，代码演示如下：
    ```py
    import dis
    lst = [4, 1, 3, 2]

    def foo():
        lst.sort()

    print(dis.dis(foo))
    ```
    > 运行后结果如下：![](https://pic4.zhimg.com/80/v2-8cdd966f7898a49453a89c9adce6ce2b_1440w.jpg)
    > 
    > 从字节码的角度，调用`sort`操作是原子级无法再分的，所以线程不会在执行期间发生GIL释放的情况，也就是说我们可以认为`sort`操作是线程安全的，不需要加锁。而我们上面演示的加法和减法操作则不是原子级的，所以我们必须要加锁才能保证线程安全。
  * > 所以，总结一下，***如果多线程的操作中不是IO密集型，并且计算操作不是原子级的操作时，那么我们需要考虑线程安全问题，否则都不需要考虑线程安全***。当然，为了避免担心哪个操作是原子的，我们可以遵循一个简单的原则：***始终围绕共享可变状态的读取和写入加锁***。毕竟，在 Python 中获取一个 `threading.Lock` 也就是一行代码的事。
- > **4. 如何避免GIL的影响**
  * > 有两个建议：
    + > 1. ***在以IO操作为主的IO密集型应用中***，多线程和多进程的性能区别并不大，原因在于即使在Python中有GIL锁的存在，由于线程中的IO操作会使得线程立即释放GIL，切换到其他非IO线程继续操作，提高程序执行效率。相比进程操作，线程操作更加轻量级，线程之间的通讯复杂度更低，建议使用多线程。
    + > 2. ***如果是计算密集型的应用***，尽量使用多进程或者协程来代替多线程。
  * > 参考资料：《深入理解 GIL：如何写出高性能及线程安全的 Python 代码》、《[Python面试不得不知道的点：GIL](https://blog.csdn.net/weixin_41594007/article/details/79485847)》。

## 文章涉及的代码个人实战运行

### (1)

```py
# coding:utf-8
import threading, time

def my_counter():
    i = 0
    for _ in range(100000000):
        i = i+1
    return True

def main1():
    thread_ary = {}
    start_time = time.time()
    for tid in range(2):
        t = threading.Thread(target=my_counter)
        t.start()
        t.join()  # 第一次循环的时候join方法引起主线程阻塞，但第二个线程并没有启动，所以两个线程是顺序执行的
    print("单线程顺序执行total_time: {}".format(time.time() - start_time))

def main2():
    thread_ary = {}
    start_time = time.time()
    for tid in range(2):
        t = threading.Thread(target=my_counter)
        t.start()
        thread_ary[tid] = t
    for i in range(2):
        thread_ary[i].join()  # 两个线程均已启动，所以两个线程是并发的
    print("并发执行total_time: {}".format(time.time() - start_time))

if __name__ == "__main__":
    main1()
    main2()
```
```
(base) $ python test_gil.py 
单线程顺序执行total_time: 13.326787233352661
并发执行total_time: 13.032700061798096

(py27) $ python test_gil.py 
单线程顺序执行total_time: 41.7955667973
并发执行total_time: 59.9498019218
```

### (2)

```py
# coding: utf-8
import threading
n = 0

def add():
    global n
    for i in range(1000000):
        n = n + 1

def sub():
    global n
    for i in range(1000000):
        n = n - 1

if __name__ == "__main__":
    t1 = threading.Thread(target=add)
    t2 = threading.Thread(target=sub)
    t1.start()
    t2.start()
    t1.join()
    t2.join()
    print("n的值为:", n)
```
```
(base) $ python test_gil2.py
n的值为: 480466
(base) $ python test_gil2.py
n的值为: -608238
(base) $ python test_gil2.py
n的值为: 612864
(base) $ python test_gil2.py
n的值为: -183138
(base) $ 
```

### (3)

```py
# coding: utf-8
import dis
n = 0

def add():
    global n
    n = n + 1
print(dis.dis(add))

def sub():
    global n
    n = n - 1
print(dis.dis(sub))
```
```
(base) $ python test_gil3.py
  7           0 LOAD_GLOBAL              0 (n)
              2 LOAD_CONST               1 (1)
              4 BINARY_ADD
              6 STORE_GLOBAL             0 (n)
              8 LOAD_CONST               0 (None)
             10 RETURN_VALUE
None
 13           0 LOAD_GLOBAL              0 (n)
              2 LOAD_CONST               1 (1)
              4 BINARY_SUBTRACT
              6 STORE_GLOBAL             0 (n)
              8 LOAD_CONST               0 (None)
             10 RETURN_VALUE
None
(base) $ 
```

### (4)

```py
# coding: utf-8
import dis
lst = [4, 1, 3, 2]

def foo():
    lst.sort()

print(dis.dis(foo))
```
```
(base) $ python test_gil4.py
  6           0 LOAD_GLOBAL              0 (lst)
              2 LOAD_METHOD              1 (sort)
              4 CALL_METHOD              0
              6 POP_TOP
              8 LOAD_CONST               0 (None)
             10 RETURN_VALUE
None
(base) $ 
```
