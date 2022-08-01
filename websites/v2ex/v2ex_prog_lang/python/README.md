
【[:star:][`*`]】 Python for 循环的效率是这么差么？还是别的什么原因？ https://www.v2ex.com/t/869981
```console
三种写法，耗时从高到低，如下面代码所示，输出结果一样。各位大佬帮忙看下原因？

第一种，耗时 7.688s
a = ''
for i in range(100000):
    a = a+str(i)+'->'

第二种，耗时 0.025s
b = ''.join([str(i)+'->' for i in range(100000)])

第三种，耗时 0.017s
c = '->'.join(map(str, range(100000)))+'->'

输出结果：0->1->2->3->4->5->6->7->8->9...->99998->99999->
```

看 pip 的启动脚本看得我人都傻了，还能把 shell 和 py 揉到一起写 https://www.v2ex.com/t/868827

网上流传最广的 Python 单例模式竟然是有问题的？ https://www.v2ex.com/t/861715

Python 日志输出异常的正确姿势？ https://www.v2ex.com/t/861072
```console
项目里为了程序在服务器上长期运行不会中断，在所有可能出异常的位置加了 try / except Exception as e ，
但是有时候需要根据日志调试错误的时候，捕捉了 e 但是不太好在日志里查看，因为不能直接 raise ，这样的话程序就中断了，
但是如果打印 e 的话又不包含整个错误的产生链，经常搞不清状况
```
- > `logger.error(MSG, ext_info=1)` 呢?
- > `traceback` 这个库可以打印
- > `traceback.print_exc()` 把错误堆栈打出来
- > loguru 直接给你把调用栈写到日志里，还支持输出异常时的变量值便于排查问题，可以试试
  >> loguru 很好用，试了下 `logger.exception` 打印信息很全。一个问题是这个默认输出的是 error 级别的，有无方法调整成 warning 级别。有一些非关键错误想用 warning ，后面还会接一个日志分析，如果 error 就告警，warning 就忽略之类的。。。
  >>> https://loguru.readthedocs.io/en/stable/overview.html 设置 level
- > `logger.exception()`试试
- > 打印 e 的代码改成 `logger.info(f'exception: {traceback.format_exc()}')` 就可以了。当然如果可以，引入第三方库更好一些
- > `logging.error("message", exc_info=e)` 就行了啊
  >> logger.error(msg, exc_info=True) / logging.error(msg, exc_info=True)
- > 试试 sentry ？
- > “项目里为了程序在服务器上长期运行不会中断，在所有可能出异常的位置加了 try / except Exception as e” <br> 这个是祸乱之源， 只要最外层捕获错误即可。
  >> 我也是这样做的，内层只 `raise` ，然后在入口处捕获处理。不知道是不是最佳实践
- > log.exception(e) 会打印完整错误堆栈

有没有一些高质量的 Python 内容推荐？ https://www.v2ex.com/t/857295

Python3 列表能被闭包函数使用，整数变量却不行呢？ https://www.v2ex.com/t/848218
```
问题：
最近在使用 python3 刷题，发现一个比较奇怪的现象，想用闭包的特性去使用一个外层作用域的变量，
如果这个变量是 list 的话，则 ok ，非 list 就会报错，我需要怎么做才可以闭包使用整数变量呢？

代码如下：

class Solution:
    def isValidBST(self, root: TreeNode) -> bool:
        pre = -sys.maxsize -1
        o = []
        def trace(root) -> bool:
            if not root:
                return True
            if not trace(root.left): return False
            o.append(root.val) # 为什么 list 可以被闭包进来
            if pre >= root.val: # 但是整数变量却不行呢？
                return False
            else:
                pre = root.val
            if not trace(root.right):return False
            return True
        return trace(root)
```
- > python 里面赋值会自动变成局部变量，你的 else 里面有赋值操作：pre = root.val
  >> 感谢，我把 pre = root.val 注释之后确实没报错了，有什么办法能在 闭包里 对外面的变量赋值呢？难道只能 read ？
>> 【[:star:][`*`]】 //notes：LeetCode 刷题时早就知道这个现象了，不过今天才知道不用 `res[0]` 或者 `nonlocal` 也是可以勉强解决的。。。

为什么 Python 用 vscode debug， step into 会跳转到意想之外的地方？ https://www.v2ex.com/t/847478

安装了 python3.10，满吃惊的 https://www.v2ex.com/t/843931
```console
居家无聊升级了 python3.10，跑了下之前 pandas ，numpy 处理数据的脚本，纯计算，没有数据库网络操作
之前 python3.6 耗时 12 分钟，相同代码，pandas,numpy 版本不同，其他一致。python 3.10 耗时 6 分钟，我惊呆了。
```
- > pandas/numpy 本身都会做很多性能优化的。特别是 numpy. 最后一个支持 python3.6 的版本是 1.19.5 两年能做很多性能优化了。比如 1.20 开始，numpy 开启了一个 SIMD 的优化计划（ NEP-0038 ）。
- > 不说别的 async 的语法 3.6 以后一个版本比一个版本简洁好用
- > Python 官方有个 benchmark： https://speed.python.org/comparison/ <br> 另外 3.9 开始用 PEG parser 了，加了一些语法糖，有一些表达比之前更简洁了。

【[:star:][`*`]】 Python 发现个奇怪知识,类属性不被实例化修改,即可被外部修改 https://www.v2ex.com/t/842921
```console
今天使用 selenium 使用拖拽效果,发现异常的慢.网上一顿搜索,发现解决办法是修改源码控制间隔的属性值..
这样太不友好了.直接全局改了.后来想看能不能外部写一个继承方法来做,看了源码后,还是放弃,水平有限.于是想的通过外部修改.
于是做了一下实验.代码如下. 备注有返回值
```
```py
class AAA():
    DEP = 0

    def get(self):
        return self.DEP

print(AAA.DEP)  # 0

AAA.DEP = 5  # 修改默认属性

ex_1 = AAA()  # 实例化 ex_1
print(ex_1.get())  # 5

AAA.DEP = 10  # 再次修改默认属性
print(ex_1.get())  # 10

ex_1.DEP = 15  # ex_1 修改实例属性
print(ex_1.get())  # 15

AAA.DEP = 12  # 再次修改默认属性
print(ex_1.get())  # 15  被上次实例化修改属性后,类属性不再被修改,即返回 15


ex_2 = AAA()  # 实例化 ex_2
print(ex_2.get())  # 12  上段 ex_2 实例化之前前修改的值

AAA.DEP = 20  # 修改原始属性
print(ex_2.get())  # 20

ex_2.DEP = 30
print(ex_2.get())

# 总结,类实例化后若原始属性不被修改 ,均可被外动态修改
```
后来再次实验,如果被 init 初始化,值也不能被修改了
```py
class AAA():
    DEP = 0
    def __init__(self):
        self.DEP=10   # 被 init 初始化后,不能被修改了
    
    def get(self):
        return self.DEP
```
```console
感觉奇奇怪怪的知识增加了..
这么说,再次使用 selenium 不用使用 time.sleep 来控制了吧. 还没试,先分享下新发现.
```
- > 建议读一读 python 官方教程中的 classes 一节。类变量和实例变量并不等价，类变量在所有实例中共享，在通过实例查找变量时实例变量优先于类变量被获取。把类变量用实例变量覆盖的方式不如通过子类覆写类变量的方式安全。
- > 你是把类变量喝对象变量混淆了。看这个 https://stackoverflow.com/a/5690920
  >> 【 Variable scopes in Python classes https://stackoverflow.com/questions/5690888/variable-scopes-in-python-classes/5690920#5690920 】
- > 省流一句话: `self.xxx` 从对象作用于里找 `xxx` 属性 /方法, 没找到, 去类作用域里面找, 找到了; `self.xxx` 赋值以后, 从对象作用域里找到了, 就不去类作用域找了

大佬们，有谁研究过 Python importlib 机制？ sys.modules 缓存太大了 https://www.v2ex.com/t/837192

【[:star:][`*`]】 请教一个 Python 浮点数的小问题 https://www.v2ex.com/t/832021
```console
v1 = 2.2 * 3 # 6.6
v2 = 3.3 * 2 # 6.6
print(v1, v2, v1==v2, v1<=v2, v1>=v2)

输出结果是：
6.6000000000000005 6.6 False False True

这个结果惊讶到我了，没想到这里也会有坑。所以浮点数比较的正确方式是？
```
- > https://docs.python.org/3/library/math.html#math.isclose
- > 跟 Python 没关系，了解一下浮点数的原理，所有的语言都这样 <br> 正确的比较，使用语言自带的浮点库，或者 v1-v2 < 0.0000……01 这样
- > https://docs.python.org/3/library/decimal.html 想要精确小数的话可以用 `decimal`
- > 我试了下 go 可以的
  ```go
  func Test_FloatEqual(t *testing.T) {
  v1 := 2.2 * 3
  v2 := 3.3 * 2
  fmt.Println(v1, v2, v1 == v2, v1 <= v2, v1 >= v2)
  }
  ```
  ```console
  输出结果：
  === RUN Test_FloatEqual
  6.6 6.6 true true true
  --- PASS: Test_FloatEqual (0.00s)
  PASS
  ```
- > Go 语言里 `2.2*3` 这种写法不涉及浮点运算，因为它是一个常量。大部分 C 语言编译器也会做这样的优化，而 Python 是“写啥跑啥”的，所以只有 Python 是真的创建了两个浮点数和两个整数并且做浮点乘法的。Go 换成这种写法你就发现区别了：
  ```go
  c1 := 2.2
  c2 := 3.3
  v1 := c1 * 3
  v2 := c2 * 2
  ```
- > 坑在于你输入的值（屏幕上显示的值）和实际值并不一样，当你输入 2.2 的时候，程序使用的实际值是 `2.20000000000000017763568394002504646778106689453125` 。Python 和很多语言认为这个精确值太长了不方便人类阅读，所以会自作主张在输出时显示为 2.2 。而你输入 3.3 的时候实际值是 `3.29999999999999982236431605997495353221893310546875` 。 <br> 所以 `2.20000000000000017763568394002504646778106689453125 * 3 >= 3.29999999999999982236431605997495353221893310546875 * 2` 为 True 没有任何问题，不信你拿计算器敲一遍 <br> 假设 Round 表示对你输入的数字取最接近的浮点数，你输入 `2.2*3 == 3.3*2` ，实际进行的是：`Round(Round(2.2) * 3) == Round(Round(3.3) * 2)` <br> Round 后的结果可能比原来大，也可能小，还可能等。所以浮点数比较只能作差取绝对值，差小于某个很小的数就认为是相等。

控制子进程的 cpu 使用率 https://www.v2ex.com/t/829345

Python 包导入的困惑 https://www.v2ex.com/t/813185

并行并发进程线程协程 GIL 概念简明解释笔记 https://www.v2ex.com/t/807569
- > **一、并发(Concurrency)和并行(Parallel)的区别**
  * > 直观来讲，并发是两个等待队列中的人***同时去竞争一台咖啡机***。现实中可能是两队人轮流交替使用、也可能是争抢使用——这就是竞争。
  * > 而并行是每个队列拥有自己的咖啡机，两个队列之间并没有竞争的关系，队列中的某个排队者只需等待队列前面的人使用完咖啡机，然后再轮到自己使用咖啡机。
- > **二、进程**
  * > 我们只需要简单的知道，他是一个基本单位，它的切换在操作系统之中，并且他的上下文切换相当的占用时间、和占据内存。
  * > Ruby 的一些框架是通过 进程+fork 的方式工作的，比如 Sidekiq 。以 fork 进程工作的会存在一切缺点：
    + > 切换上下文时间相对较长
    + > 上下文的内存相对较大
    + > fork 的子进程，当父进程死掉，会成为僵尸进程，等待系统回收（占用内存）
- > **三、线程**
  * > 3.1 多线程的意义
    + > 共享内存
    + > 切换上下文时间段
    + > 占用内存少
    + > 父进程关闭，子进程自动关闭
    + > 任务分片
  * > 3.2 线程存在的问题
    + > 竞争带来的复杂问题，涉及到锁
- > **四、GIL**
- > **五、协程**
  * > 线程是由操作系统来控制切换的。而系统的切换是一种通用的策略，在一些场景下会没必要的浪费时间。
  * > 协程 就是一种让程序员去手动切换，这个过程就像 线程之间 可以互相协作 来完成任务，避免不必要的切换。具体如何切换、交给谁，这个根据实际的任务，程序员来判断。
  * > 比如 小明做 语文、数学、英语三节课。系统调度采用的是通用策略，他可能的选择是在三个任务之间均衡。系统不停地在切换，实际上这种切换浪费了大量的时间。

Python 类中类型提示使用“定义类”提示未定义 https://www.v2ex.com/t/800920

《 Python 进阶》2021 更新版发布，欢迎大家提出意见或表示支持 https://www.v2ex.com/t/797304
```console
忘记附上阅读链接和源码地址了 :)
在这阅读：https://py.eastlakeside.cn/
在这提PR或issue，或star支持：https://github.com/eastlakeside/interpy-zh
```

在 Python 中如何放置一个钩子劫持接下来发生的标准输出？ https://www.v2ex.com/t/794208
- > 
  ```py
  from unittest.mock import patch
  _print = print
  with patch('builtins.print') as mock:
  mock.side_effect = lambda x: _print("whatever you want")
  import a
  ```

Python 起多个线程会充分用到多核 cpu 的资源吗 https://www.v2ex.com/t/788109
- > CPython 不会，应该有 Global Interpreter Lock ( https://realpython.com/python-gil/ )。对于衍生品如 pypy，则可以。对于 CPython，多核的利用是利用子进程。
- > python(cpython) 多进程会利用多核，多线程不行，默认的 pypy 也一样，好像 pypy 有个 no gil 的实验版

如何知道一段代码没有内存泄漏？假如一个函数 cache 了返回值，算不算内存泄露呢?？ Python 中内存泄漏的标准又是什么？？ https://www.v2ex.com/t/783580
- > 内存泄漏，就是程序中出现了非设计内的内存使用。 <br> 比如你给出一个 Python 函数的默认参数值是 `[]`，然后你又在函数内部直接往这个 list 增加内容了，导致这个列表占用的内存大小不断上升，且永不会被 Python GC 机制回收。这就是一种常见的 Python 程序内存泄漏情况。
- > 我以为你在说 C/C++，valgrind+address sanitizer 解决一切问题
- > 申请的内存脱离了代码的控制范围，如果进程不退出永远没法释放

给同事讲 Python 的高级用法, 有没有提纲什么的... https://www.v2ex.com/t/777709

Python 的 gil 到底解决了什么具体的问题？ https://www.v2ex.com/t/777560

日常中如何解决 Python 中字典是无序这一问题的 https://www.v2ex.com/t/776937
- > 升级 Python 程序
- > Python 3.6 中 dict 就已经有序了，而 3.7 起 dict 保持插入顺序成为了正式的 feature。所以，你该升级 Python 了……
- > 没搞懂为什么那么多人说“升级 Python”或者“Python3.6 就已经有序了“，这个有序说的是插入的有序。而提问者的问题是”键按字母顺序排序或者按值排序“吧？
  >> 提问者在 6 楼和 7 楼都说了，「只是想让他按照我写的顺序显示」，「不是为了排序只是为了按照我写的顺序展示」
- > HashMap 是“无序”的，它的“序”靠的是 Hash 值，如果要“有序”可以用红黑树之类结构，但代价是你只能用你排序的那个字段做快速查找、插入了。如果即需要用 Key 快速查找、插入，又希望用别的参数来做“序”那么可能你需要一个符合的数据结构。
- > https://docs.python.org/zh-cn/3/library/stdtypes.html#mapping-types-dict  在 3.7 版更改: 字典顺序会确保为插入顺序。 此行为是自 3.6 版开始的 CPython 实现细节。

Python 终于决定要提升一下性能了 https://www.v2ex.com/t/776893

cmd 运行 Python 文件时遇到错误如何停留界面？ https://www.v2ex.com/t/758927
- > 最后加上 os.system("pause")
- > 用 try-catch 包住整个主函数，捕捉所有异常后 input("Press any key...")

Python 3.7 的内置 breakpoint() 函数如何 backport 到 3.6 中？ https://www.v2ex.com/t/752234

py 怎么判断是通过 IDE 运行还是 cmd 运行？ https://www.v2ex.com/t/752407
```console
py 文件最后有 os.system("pause")，以在 cmd 里执行完毕后保留窗口供观察，并按任意键取消；但在 IDE 里直接运行完毕后，
IDE 始终处于运行状态，必须得强行关闭。是否有办法加个 IF 判断运行方式来决定是否调用最后一句？
```
- > 换个思路 `python 1.py & pause()`
- > 最后换成 `input_to_break=inupt("pls input to break")` 这样行吗
- > 直接 input() 就好了，为什么要用 cmd 的 pause ？IDE 出现这种情况可能是因为 IDE 内置的终端实现有问题，如果可以的话建议提交 bug 。
  >> 因为这种非入侵式的实现可以不用修改代码，想想看如果我有几十个文件要通过这种方式运行，你一个一个地去加 input，跑完了再一个一个删？
  >>> 但 os.system 不是也要加代码吗？
  >>>> 这是运行命令后面加 `& pause()` ，不需要在代码里加 os.system()
  >>>>> 我说的是楼主的方法，既然要修改代码，那直接用 input() 就好了，没必要用 cmd 的 pause 。
  >>>>>> 不光是 python，其它的命令也可以这样，比如 ipconfig 默认执行之后是一闪而过的，用 `ipconfig & pause()` 能让命令执行完把窗口保留着

遇到了 Python 的少见语法问题 https://www.v2ex.com/t/750370
- > 3.5 引入的一个新运算符 `__matmul__`,  https://www.python.org/dev/peps/pep-0465/  https://docs.python.org/3/reference/datamodel.html#emulating-numeric-types 支不支持取决于这个类型有没有实现这运算符，正如其名它是用来进行矩阵乘法的，一般的数据结构不支持也是自然的
- > a1 @ b1 等价于 a1.dot(b1)，其实我认为这是一个毫无价值、根本没必要引入的新语法。

"a == b" 与"id(a) == id(b)"的本质区别 https://www.v2ex.com/t/747425

如何在 list 内通过条件表达式来决定一个值是否存到 list 内？ https://www.v2ex.com/t/738653
```console
当a为True时展示出来，为False时不展示，想学习pythonion（这个词咋写的不会😂）的写法，大概如下，
但a是True会报错，如何改一下呢？
```
- > 个人实战：
  ```py
  a=None
  mylist = [1,2,*(a if a else []),4]
  print(mylist)
  
  a=1
  mylist = [1,2,*(a if a else []),4]
  print(mylist)
  --------------------------------------------------
  [1, 2, 4]
  Traceback (most recent call last):
    File "main.py", line 6, in <module>
      mylist = [1,2,*(a if a else []),4]
  TypeError: 'int' object is not iterable
  ```
  ```py
  a=None
  mylist = [1,2,*([a] if a else []),4]
  print(mylist)
  
  a=1
  mylist = [1,2,*([a] if a else []),4]
  print(mylist)
  --------------------------------------------------
  [1, 2, 4]
  [1, 2, 1, 4]
  ```
  >> 另外，这个语法貌似只有python3下才行，我开始用python2试，都过不去。会在星号的位置提示`SyntaxError: invalid syntax`。

Python 代码的保密的一些问题 https://www.v2ex.com/t/737588
- > 这问题每年都会问几次 /t/624292 你把环境折腾好能跑起来就可行
  >> Python 代码的加密问题 https://www.v2ex.com/t/624292

粗看 numpy 和 pandas 后的一点困惑 https://www.v2ex.com/t/732958
- > pandas 计算移动平均线：`df.rolling(15).mean()`，sql：卒。 <br> numpy 计算数组拟合函数：`np.polyfit(x, y, 1)`，excel：卒。 <br> pandas 计算 后 N 天减前 N 天值：`df.diff(N)`，sql：卒。
- > sql 也可以做移动平均的 https://ubiq.co/database-blog/calculate-moving-average-postgresql/

这个协程例子中， consumers 是怎么被执行的？ https://www.v2ex.com/t/728390

Python in 操作在 tuple 和 list 中到底哪个快？ https://www.v2ex.com/t/726235

请问如何判断启动某个 Python 进程的 Python 环境位置呢？ https://www.v2ex.com/t/725220
- > strings /proc/pid/environ 看这个进程的环境变量 应该有这个进程是那个虚拟环境的
- > 虽然你已经解决了, 顺嘴一提 psutil 的 cmdline 不知道能不能帮到你, 先通过 pid 拿到 Process 对象, 然后看它启动时候命令行参数里面的路径
  >> 谢谢老哥，也是一种很优雅的解决方式 供其他人参考
    ```py
    import psutil
    pp = psutil.Process(16049)
    print(pp.cmdline())
    # 或者 print(pp.environ())
    ```

老生常谈，但还是问一下， Python env 选择 https://www.v2ex.com/t/720757

如何在 Python 中嵌入汇编代码，比如 hook 一个软件， c 语言里可以直接内联汇编，不知道 Python 这样才可以有这种操作 https://www.v2ex.com/t/720690

请教如何使用 Python 直接对二进制文件进行修改 https://www.v2ex.com/t/719647

听说 Python 的多线程是假的，无法利用多核心？ https://www.v2ex.com/t/719053

求 Python 练习题 https://www.v2ex.com/t/714540
- > 类似这种的吗 https://www.runoob.com/python3/python3-examples.html
- > https://www.hackerrank.com/domains/python
- > https://www.codewars.com/
- > codewars +1 做完后还可以参考别人的答案…… best practice 什么的 <br> 7-8 级的题适合入门，4 级以上的题大部分都比较难，很多题不折腾几个小时出不来。初段题是不是就是接近一个小课题？另外还有各种语言，js，java，rust，go 等等

【[:star:][`*`]】 宣传一下 Cyberbrain，真正解放程序员的 Python 调试工具 https://www.v2ex.com/t/713201
- > https://github.com/laike9m/Cyberbrain
- > 简单来说，Cyberbrain 可以实现精确的变量溯源，并且让用户查看变量在任意时刻的值。这些传统的 debugger 都做不到。
- > 看示意图好像是用 github-codespaces 开发的？
  >> #12 我申请了 codespaces 但还没给我批。之后会支持。目前支持 VS Code 和 Gitpod
- > 这类 trace 工具让我很困惑的一点就是几亿次循环那种变量变化特别快的，然后又是 2G 的 json 在里面变来变去的怎么办。
  >> #14 这确实是个问题，不过我有大致的解决思路，就是隔一段时间把数据 dump 到磁盘一次。目前还没有着手优化这一块，不过是在计划内的。
- > 感觉和 pysnooper 功能差不多呀
  >> 我不喜欢自吹，但是 cyberbrain 完爆 snooper （虽然目前还不支持追踪深层的函数调用）。pysnooper 真的没什么技术含量，它的核心功能我两天就能写出来
  >>
  >> pysnooper 只能告诉你 a 变了，但它不能告诉你 a 变化的来源，以及变化来源的来源，而这是 cyberbrain 的核心功能。
- > 追踪来源有点意思，那确实跟 pysnooper 侧重点不一样了
  >> 恩，因为 pysnooper 分析的是行级别的变化，而 cb 是在字节码级别做追踪的，拿到的信息要多太多，准确度也更高
- > async 的支持怎么样？
  >> 在项目页面有后续版本的路线图，预计会在 4.0 支持。当然，我更希望有人能加入一起做，如果是我一个人的话 async 确实要等比较久了
- > 很不错，下一版开发 go trace?
  >> #27 谢谢。Cyberbrain 是 Python only 的，Go 可能需要更熟悉 Go 的人来开发，而且我怀疑在 Go 里能否拿到需要的信息
- > #26 怪我。。。我 py 版本 367 的。
  >> #29 嗯，支持 Python 3.7+（过几天就支持 3.9 ）。主要是因为用了一个 3.7 里新加的 API
- > 做 Go 的和这个完全不一样了，需要面向二进制配合符号做，部分功能恐怕需要魔改 runtime
- > 是不是不支持递归函数啊，刚刚随手拿裴波那契数列的递归写法试了一下，结果报 AssertionError 了，又试了几个其他的递归函数，无一例外全部报错。正常写法的函数都没问题，应该不是我的环境的原因吧
  >> #33 非常感谢，能帮忙提个 issue 吗？我会尽快修复 https://github.com/laike9m/Cyberbrain/issues/new
  >>> https://github.com/laike9m/Cyberbrain/issues/43
- > 我不太懂这些，不过这个变量可视化的部分和 https://marketplace.visualstudio.com/items?itemName=hediet.debug-visualizer 有什么差别吗
  >> #37 哈哈，它们长得像是因为都用了 vis-network 这个可视化库🙈 不过目的是完全不一样的。debug-visulizer 是可视化数据结构，Cyberbrain 是可视化代码执行流程

python3 新特性这么多，你常用的是什么？ https://www.v2ex.com/t/713227
- > type hint，dataclass
- > type hint 和 f-string，应该大多数人都是这两个
- > asyncio 吧 python2 gevent 文档太少
- > async/await asyncio typehints dataclass f-string
- > f-string dataclass enum  type-hint 还能帮助代码提示

请教 Python 多线程内存不释放怎么排查 https://www.v2ex.com/t/712846

Python 类相关问题 https://www.v2ex.com/t/702580

在 python3 中, 字节流如何转换成字符串 https://www.v2ex.com/t/695185

《捕蛇者说》16 期发布： Goodbye Python 2, Hello Python 3！ https://www.v2ex.com/t/693282

有在线编写 Python 代码并能执行的开源项目吗 https://www.v2ex.com/t/692173
- > IBM Cloud Fonudray 和 Github Action 可以去看一下。
- > Polynote
- > https://e.coding.net/login 在线 VS Code，不开源，五人以下免费。

Python 多重继承的问题 为什么以下代码里 Base 的 __init__ 没有被调用 https://www.v2ex.com/t/690995

Python 多线程的问题 https://www.v2ex.com/t/674432
```py
total = 0

def add():
    #1. dosomething1
    #2. io 操作
    # 1. dosomething3
    global total
    for i in range(1000000):
        total += 1
def desc():
    global total
    for i in range(1000000):
        total -= 1

import threading
thread1 = threading.Thread(target=add)
thread2 = threading.Thread(target=desc)
thread1.start()
thread2.start()

thread1.join()
thread2.join()
print(total) # 178412
```
- > 简单来说 total 不是线程安全的，这个不只在 Python 中会出现，而是任何多线程语言下都会出现的现象，解决方案就是访问前加锁，或者用原子操作
- > GIL：执行是单线程的，不代表线程的上下文是受保护的。即单线程的执行方式!=线程安全。
- > 你可以 dis 看下生成的字节指令就知道了，+= 1 也是需要好多条指令的，python 的 GIL 应该只是在单条字节指令保证原子性吧，但是你一行代码很多时候都是多条字节指令的吧
- > += 和 -= 不是原子的
- > 1.GIL 意思是任何时候只有一个线程运行 <br> 2.因为增量赋值不是原子操作，具体可看 dis.dis('a += 1') 的字节码不止一步 <br> 3.线程是系统调度的，你不知道何时切换 <br> 4.好，那你怎么就知道在做增量赋值的字节码某一步的时候，不会切换到了另一个线程呢？
- > 全局定义一个 lock = threading.Lock()，+=、-=之前增加一个 with lock:的块
  >> notes：我查了也试了下，比较简单的做法是用`lock.acquire()`和`lock.release()`把`total += 1`和`total -= 1`包起来就行。参照下面这个页面：
  >>> https://python-parallel-programmning-cookbook.readthedocs.io/zh_CN/latest/chapter2/06_Thread_synchronization_with_Lock_and_Rlock.html

请教： Python 获取 shell 自定义变量的值。 https://www.v2ex.com/t/658012
```console
我在当前 shell 中定义了 test 这个自定义变量，同时，我启动了一个 Py 脚本，这个 Py 脚本有没有办法获取当前 shell 的
自定义变量（比如这个$test ）的值？

要求：不将自定义变量导出为环境变量。
```
- > 你这需求也太扭曲了，为啥会有这种需求，原始问题是什么？而扭曲的需求只有用扭曲的办法解决了：gdb attach 上去找
  >> 
  ```py
  #!/usr/bin/env python3
  from pygdbmi.gdbcontroller import GdbController
  import os

  gdbmi = GdbController()
  gdbmi.write(f"attach {os.getppid()}")
  res = gdbmi.write('p (char *)get_string_value("foo")')

  for mes in res:
      if "$1" in str(mes.get("payload", "")):
          print(mes["payload"])
  ```

Python 的协程到底有啥用啊… 
- > 一篇文章理解Python异步编程的基本原理 https://mp.weixin.qq.com/s/spayiLNuTnFVOWWeW-jkwQ
  * > 以 request 请求URL 为例，requests 发起请求，也许只需要0.01秒的时间。然后程序就卡住，等待网站返回。请求数据通过网络传到网站服务器，网站服务器发起数据库查询请求，网站服务器返回数据，数据经过网线传回你的电脑。requests 收到数据以后继续后面的操作。 <br> 大量的时间浪费在等待网站返回数据。如果我们可以充分利用这个等待时间，就能发起更多的请求。而这就是异步请求为什么有用的原因。 <br> 但对于需要大量计算任务的代码来说，CPU 始终处于高速运转的状态，没有等待，所以就不存在利用等待时间做其它事情的说法。 <br> 所以：**异步只适用于 I/O 操作相关的代码，不适用于非 I/O操作**。
- > Python异步编程详解 https://hatboy.github.io/2019/02/16/Python%E5%BC%82%E6%AD%A5%E7%BC%96%E7%A8%8B%E8%AF%A6%E8%A7%A3/
- > 协程是单线程的，因此你必须保证你的所有“阻塞”操作都是异步的，不然对性能没有任何提升。比如你用 requests 写爬虫程序。由于 requests 的操作都是阻塞的，用协程不会带来任何的性能提升。要想提升性能得把 requests 换成非阻塞的库，如 aiohttp 。
- > 推荐一篇文章， https://snarky.ca/how-the-heck-does-async-await-work-in-python-3-5/  <br> 作者从头讲解了 Python 协程的工作原理，并实现了一个简易的事件循环，有助于理解基于 Python 协程的工作原理。 <br> 但是这个说的是原理，目前可能不太适合你看。之后有兴趣可以看下，看完可以再读下 asyncio 库的源码。Python 协程本质是依赖 IO 多路复用和 yield 去实现异步的，所以只有网络 IO 才有必要使用协程。
- > 协程的本质是保存当前函数或者例程的运行状态，并主动让出 CPU 资源，使得和当前函数处于"平级"的函数或者是例程能够得到 CPU 资源，并于原有保存点继续执行，整个过程只有少量的函数运行点恢复操作，没有重量级的线程(进程)上下文切换，所以在同样任务的情况下，协程比线程、进程拥有更高的执行效率。Python 的协程，对我个人而言还不如线程好用，宁愿使用 gevent patch，也不愿意使用 asyncio 。协程还是 Golang 用起来更加顺手。
- > 协程仅使用于类似爬虫或服务这种持续性 io 密集的程序，其他平砍算法可以解决的事情用协程就是增加心智负担。

Python3 里面 u 和 U 的区别是什么 https://www.v2ex.com/t/655586
- > https://stackoverflow.com/questions/46132917/python-3-and-x-vs-u-vs-u-in-string-encoding-and-why

字典.keys()获得的键列表元素顺序是随机的吗？ https://www.v2ex.com/t/634283
- > 随机的，需要顺序，用 ordered dict
- > dart 有一个叫 LinkedHashMap,那是有顺序的
- > Python 3.7+ https://docs.python.org/3.7/whatsnew/3.7.html <br> In Python 3.7.0 the insertion-order preservation nature of dict objects has been declared to be an official part of the Python language spec. Therefore, you can depend on it.
- > 虽然有 order dict，但内部是有序的。如同上面老哥所述，在 3.x （ x 是几我给忘了）后的版本是有序的

Python 为什么趋近于零的数字会表示成 5.96046448e-08 https://www.v2ex.com/t/629937
- > 15. 浮点算术：争议和限制 https://docs.python.org/zh-cn/3.8/tutorial/floatingpoint.html

刚搞懂一个 logging 的用法，分享一下。 https://www.v2ex.com/t/613320

Python 之父开博客写的解析器系列文章 https://www.v2ex.com/t/588878

cpython 底层实现笔记 https://www.v2ex.com/t/560173
> Dive into CPython internals, trying to illustrate every detail of CPython implementation | CPython 源码阅读笔记, 多图展示底层实现细节 https://github.com/zpoint/CPython-Internals

:u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272::u5272:
