
# PDB参数

10分钟教程掌握Python调试器pdb - splinzer的文章 - 知乎 https://zhuanlan.zhihu.com/p/37294138 || https://www.jianshu.com/p/01e76c5208f7
- > **1、查看源代码**
  * > 命令：`ll` <br> 说明：查看当前函数或框架的所有源代码
- > **7、非逐行调试命令**
  * > 命令2：`unt lineno` <br> 说明：持续执行直到运行到指定行（或遇到断点）
- > **8、查看函数参数**
  * > 命令：`a` <br> 说明：在函数中时打印函数的参数和参数的值
- > **9、打印变量类型**
  * > 命令：`whatis expression` <br> 说明：打印表达式的类型，常用来打印变量值

# PDB

`26.2. pdb — The Python Debugger` https://docs.python.org/2/library/pdb.html

pdb --- Python 的调试器 https://docs.python.org/zh-cn/3/library/pdb.html
- > 3.7 新版功能: 内置函数 `breakpoint()`，当以默认参数调用它时，可以用来代替 `import pdb; pdb.set_trace()`。

<<用PDB库调试Python程序>> http://www.cnblogs.com/dkblog/archive/2010/12/07/1980682.html
- > 用pdb调试有多种方式可选：
  * > 1.命令行启动目标程序，加上 `-m` 参数，这样调用 `myscript.py` 的话断点就是程序的执行第一行之前 `python -m pdb myscript.py`
  * > 2.在Python交互环境中启用调试
    ```py
    >>> import pdb
    >>> import mymodule
    >>> pdb.run(‘mymodule.test()’)
    ```
  * > 3.比较常用的，就是在程序中间插入一段程序，相对于在一般IDE里面打上断点然后启动debug，不过这种方式是hardcode的
    ```py
    if __name__ == "__main__":
        a = 1
        import pdb
        pdb.set_trace()
        b = 2
        c = a + b
        print (c)
    ```
    > 然后正常运行脚本，到了 `pdb.set_trace()` 那就会定下来，就可以看到调试的提示符(Pdb)了

Python Debugging With Pdb https://realpython.com/python-debugging-pdb/

How To Use the Python Debugger https://www.digitalocean.com/community/tutorials/how-to-use-the-python-debugger

Python 程序如何高效地调试？ - 知乎用户的回答 - 知乎 https://www.zhihu.com/question/21572891/answer/149974828

Python 代码调试技巧 https://www.ibm.com/developerworks/cn/linux/l-cn-pythondebugger/
