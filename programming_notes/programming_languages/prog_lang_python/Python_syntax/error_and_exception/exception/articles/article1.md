
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
