
PythonDebuggingTools https://wiki.python.org/moin/PythonDebuggingTools
- DebuggingWithGdb https://wiki.python.org/moin/DebuggingWithGdb

# pdb++

pdb++, a drop-in replacement for pdb https://github.com/pdbpp/pdbpp

# ipdb

Python 程序如何高效地调试？ - Rui L的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/26046582

Python 程序如何高效地调试？ - 小明的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/123220574

# ~~ptvsd~~  -->  debugpy

debugpy - a debugger for Python https://github.com/microsoft/debugpy

🛑 ᴘᴛᴠsᴅ ɪs ᴅᴇᴘʀᴇᴄᴀᴛᴇᴅ 🛑 https://github.com/microsoft/ptvsd
- > A replacement implementation of DAP for Python is [debugpy](https://pypi.org/project/debugpy/), which is based on the development branch (5.x) of ptvsd. All future development is going to be happening in debugpy; there will be no further commits to or releases of ptvsd.

Remote Debugging https://donjayamanne.github.io/pythonVSCodeDocs/docs/debugging_remote-debugging/

# remote-pdb

Remote vanilla PDB (over TCP sockets). https://github.com/ionelmc/python-remote-pdb

# 调试多进程程序

How to attach debugger to a python subproccess? https://stackoverflow.com/questions/4716533/how-to-attach-debugger-to-a-python-subproccess/23654936#23654936
- https://stackoverflow.com/questions/4716533/how-to-attach-debugger-to-a-python-subproccess/72532079#72532079
  * > Just use PuDB that gives you an awesome TUI (GUI on terminal) and supports multiprocessing as follow:
    ```py
    from pudb import forked; forked.set_trace()
    ```
    >> 【[:star:][`*`]】 //notes：尽管这个答案很短，并且也没被选为最佳答案，但是其实这个回答里的办法是最好的（我没有完全照搬，因为 Python 后来引入了官方的 `breakpoint()` 语法，用改环境变量的方式来灵活调用需要的 debugger 更好，参见：https://documen.tician.de/pudb/starting.html#using-the-debugger-after-forking ）。于是最简单快速的用法就是代码里（多进程执行的函数的某个位置）添加 `breakpoint()`，然后执行（当然也可以把 `export PYTHONBREAKPOINT=pudb.forked.set_trace` 放在 `~/.bashrc` 里，这样不用每次都输入了）：
    ```sh
    PYTHONBREAKPOINT=pudb.forked.set_trace python script.py
    ```
- https://stackoverflow.com/questions/4716533/how-to-attach-debugger-to-a-python-subproccess/60123764#60123764
  >> //notes：这个回答里提到的 `remote_pdb` 大致看了看，没有试，回头也可以试试。

How to use ipdb.set_trace in a forked process https://stackoverflow.com/questions/26289153/how-to-use-ipdb-set-trace-in-a-forked-process

Debug Multiprocessing In Python https://unbiased-coder.com/debug-multiprocessing-in-python/
- > **5. Use Inter Process Communication**

# birdseye

birdseye https://github.com/alexmojaki/birdseye

Birdseye 极其强大的Python调试工具 https://juejin.cn/post/7127830197407072270 || https://cloud.tencent.com/developer/article/1825280 || https://zhuanlan.zhihu.com/p/421961147

# `q` (and `logging`?)

In python, is there a way to automatically log information any time you create a variable? https://stackoverflow.com/questions/62844130/in-python-is-there-a-way-to-automatically-log-information-any-time-you-create-a
- https://stackoverflow.com/questions/62844130/in-python-is-there-a-way-to-automatically-log-information-any-time-you-create-a/62844789#62844789

q https://github.com/zestyping/q || https://pypi.org/project/q/
- > Quick and dirty debugging output for tired programmers. ⛺
- > Install `q` with `pip install -U q`.
- > All output goes to `/tmp/q` (or on Windows, to `$HOME/tmp/q`). You can watch the output with this shell command while your program is running:
  ```sh
  tail -f /tmp/q
  ```
- > To trace a function (showing its arguments, return value, and running time), insert this above the `def`:
  ```py
  import q
  @q
  ```
- > To start an interactive console at any point in your code, call `q.d()`:
  ```py
  import q; q.d()
  ```
- > **Other projects inspired by this one**
  * [`q` for golang](https://github.com/y0ssar1an/q)
  * [`qq` for elixir](https://github.com/mandarvaze/q)
  * [`ic` for Python](https://github.com/gruns/icecream) - Similar library for Python, inspired by `q`.
- > The following [Lightning Talk](http://pyvideo.org/video/1858/sunday-evening-lightning-talks#t=25m15s) shows how powerful using q can be.

How does q work? https://www.pythoninsight.com/2018/05/how-does-q-work/

How to log a variable's name and value? https://stackoverflow.com/questions/19317770/how-to-log-a-variables-name-and-value
- https://stackoverflow.com/questions/19317770/how-to-log-a-variables-name-and-value/19318417#19318417
  * > If the tool you need is only for developing and debugging, there's a useful package called [q](https://github.com/zestyping/q).
  * > It has been submitted to pypi, it can be installed with `pip install q` or `easy_install q`.
    ```py
    import q; q(foo)

    # use @q to trace a function's arguments and return value
    @q
    def bar():
       ...

    # to start an interactive console at any point in your code:
    q.d()
    ```
  * > The results are output to the file `/tmp/q` (or any customized paths) by default, so they won't be mixed with stdout and normal logs. You can check the output with `tail -f /tmp/q`. The output is highlighted with different colors.
  * > The author introduced his library in a lightning talk of PyconUS 2013. The video is [here](https://youtu.be/OL3De8BAhME), begins at [25:15](https://www.youtube.com/watch?v=OL3De8BAhME&t=1515s).

# debug with records and logs by `logging` or other modules
>> 【[:star:][`*`]】 //notes：其实开始是想利用 `logging` 之类的日志库，***把每一步运行完当前所有的变量值、代码到哪一行了之类的信息全都打印到日志里，这样其实就能起到 `gdb` 的效果了***（虽然日志文件一定会巨大，但是可以只关注自己想关注的那几行代码或者函数执行前后的变量/返回值变化就行。）。后来发现了 `q` 这个库，但是这个库不见得能 100% 达到我想要的效果，而且就算能，自己也可以写写试试。

目前看来能起到帮助的函数、模块等包括：
- `dir()`，以及 `globals()`，`locals()`，`vars()`
- `pprint.pprint()`
- `ast.literal_eval()`
- `traceback.print_exc()`，`traceback.format_exc()`
- `sys._getframe().f_code.co_name`，`sys._getframe().f_code.co_filename`，`sys._getframe().f_lineno`
- `sys._getframe(1).f_globals.get()`

## 打印所有变量
- Viewing all defined variables in Python https://www.geeksforgeeks.org/viewing-all-defined-variables-in-python/
- How to get a list of variables in specific Python module? https://stackoverflow.com/questions/9759820/how-to-get-a-list-of-variables-in-specific-python-module
- Viewing all defined variables [duplicate] https://stackoverflow.com/questions/633127/viewing-all-defined-variables
- Enumerate or list all variables in a program of [your favorite language here] [closed] https://stackoverflow.com/questions/430811/enumerate-or-list-all-variables-in-a-program-of-your-favorite-language-here

## 打印文件名、函数名、行号等 --> 参见[这里的总结](../README.md#个人总结-python-语言版)。
- Python之sys._getframe() https://www.cnblogs.com/hester/articles/4767152.html
- Python sys._getframe() Examples https://www.programcreek.com/python/example/283/sys._getframe

Python's `__FILE__`, `__FUNC__` and `__LINE__` - 李辉的文章 - 知乎 https://zhuanlan.zhihu.com/p/58840146
>> //notes：书中代码个人实战（效果一般吧，函数名打印得不好，回头改进一个）：
  ```py
  def file_func_line():
      """Return the line number from which this functions got called.
      http://stackoverflow.com/q/6810999"""
      import inspect
      frame = inspect.stack()[1][0]
      info = inspect.getframeinfo(frame)
      return inspect.__file__, info.function, info.lineno

  print(file_func_line())

  for i in range(5):
      print(file_func_line())
  ```
  ```console
  ('/usr/local/lib/python3.7/inspect.py', '<module>', 9)
  ('/usr/local/lib/python3.7/inspect.py', '<module>', 12)
  ('/usr/local/lib/python3.7/inspect.py', '<module>', 12)
  ('/usr/local/lib/python3.7/inspect.py', '<module>', 12)
  ('/usr/local/lib/python3.7/inspect.py', '<module>', 12)
  ('/usr/local/lib/python3.7/inspect.py', '<module>', 12)
  ```

Python equivalent to C++ `__LINE__` https://stackoverflow.com/questions/56762491/python-equivalent-to-c-line

Python获取当前位置所在行数以及函数名 https://cloud.tencent.com/developer/article/2171927

python笔记19-获取当前运行函数名称和类方法名称 https://www.cnblogs.com/yoyoketang/p/9231320.html

## 每一行代码都打印一下（pysnooper里可能也是这么实现的？）

python tracing a segmentation fault https://stackoverflow.com/questions/2663841/python-tracing-a-segmentation-fault/2664232#2664232
- https://stackoverflow.com/questions/2663841/python-tracing-a-segmentation-fault/2663863#2663863
  * > Here's a way to output the filename and line number of every line of Python your code runs:
    ```py
    import sys

    def trace(frame, event, arg):
        print("%s, %s:%d" % (event, frame.f_code.co_filename, frame.f_lineno))
        return trace

    def test():
        print("Line 8")
        print("Line 9")

    sys.settrace(trace)
    test()
    ```
  * > Output:
    ```console
    call, Main.py:7
    line, Main.py:8
    Line 8
    line, Main.py:9
    Line 9
    return, Main.py:9
    ```
  * > (You'd probably want to write the trace output to a file, of course.)

# 其他

Debugging Python Like a Boss https://zapier.com/engineering/debugging-python-boss/
- pydbgr

Cyberbrain: Python debugging, redefined. https://github.com/laike9m/Cyberbrain
- > Cyberbrain consists of a Python library and various editor/IDE integrations. Currently it supports VS Code and Gitpod. See our plan on expanding the support.

ApacheCN Python 译文集 https://github.com/apachecn/apachecn-python-zh
- 七、测试和调试分布式应用 （Distributed Computing with Python） https://github.com/apachecn/apachecn-python-zh/blob/8707a37451/docs/py-dist-comp/8.md || https://py.apachecn.org/#/docs/py-dist-comp/8
