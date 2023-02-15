
# 1

Python Exception Handling Using try, except and finally statement https://www.programiz.com/python-programming/exception-handling

## 个人实战（说明没有异常的情况下，程序一下子就自己退出了）

>> //notes：没有异常机制时，碰到第一个错就强制退出了（必然的，后面的部分也运行不了了），无法根据不同的“异样”做不同的处理，甚至除了退出没有别的处理。。。（现实生活中的程序，可能有些“异样”并不需要退出，记个告警日志还可以继续服务；即使退出，也可能要用一些逻辑来处理退出前的现场，比如关闭打开的文件句柄等）
```py
randomList = ['a', 0, 2]
for entry in randomList:
    print("The entry is", entry)
    r = 1/int(entry)
```
```console
The entry is a
Traceback (most recent call last):
  File "main.py", line 19, in <module>
    r = 1/int(entry)
ValueError: invalid literal for int() with base 10
```

>> //notes：有异常机制时，至少可以继续往下运行（后续捕获异常后可以用不同的处理方式）
```py
import sys
randomList = ['a', 0, 2]
for entry in randomList:
    try:
        print("The entry is", entry)
        r = 1/int(entry)
        break
    except:
        print("Oops!", sys.exc_info()[0], "occurred.")
        print("Next entry.")
        print()
print("The reciprocal of", entry, "is", r)
```
```console
The entry is a
Oops! <class 'ValueError'> occurred.
Next entry.

The entry is 0
Oops! <class 'ZeroDivisionError'> occurred.
Next entry.

The entry is 2
The reciprocal of 2 is 0.5
```

# 2

14.7 捕获所有异常 https://python3-cookbook.readthedocs.io/zh_CN/latest/c14/p07_catching_all_exceptions.html
- > **问题**
  * > 怎样捕获代码中的所有异常？
- > **解决方案**
  * > 想要捕获所有的异常，可以直接捕获 `Exception` 即可：
    ```py
    try:
       ...
    except Exception as e:
       ...
       log('Reason:', e)       # Important!
    ```
  * > 这个将会捕获除了 `SystemExit` 、 `KeyboardInterrupt` 和 `GeneratorExit` 之外的所有异常。 如果你还想捕获这三个异常，将 `Exception` 改成 `BaseException` 即可。
- > **讨论**
  * > 捕获所有异常通常是由于程序员在某些复杂操作中并不能记住所有可能的异常。 如果你不是很细心的人，这也是编写不易调试代码的一个简单方法。
  * > 正因如此，如果你选择捕获所有异常，那么在某个地方（比如日志文件、打印异常到屏幕）打印确切原因就比较重要了。 如果你没有这样做，有时候你看到异常打印时可能摸不着头脑，就像下面这样：
    ```py
    def parse_int(s):
        try:
            n = int(v)
        except Exception:
            print("Couldn't parse")
    ```
    > 试着运行这个函数，结果如下：
    ```py
    >>> parse_int('n/a')
    Couldn't parse
    >>> parse_int('42')
    Couldn't parse
    >>>
    ```
    > 这时候你就会挠头想：“这咋回事啊？”
  * > 假如你像下面这样重写这个函数：
    ```py
    def parse_int(s):
        try:
            n = int(v)
        except Exception as e:
            print("Couldn't parse")
            print('Reason:', e)
    ```
    > 这时候你能获取如下输出，指明了有个编程错误：
    ```py
    >>> parse_int('42')
    Couldn't parse
    Reason: global name 'v' is not defined
    >>>
    ```
    > 很明显，你应该尽可能将异常处理器定义的精准一些。 不过，要是你必须捕获所有异常，确保打印正确的诊断信息或将异常传播出去，这样不会丢失掉异常。
